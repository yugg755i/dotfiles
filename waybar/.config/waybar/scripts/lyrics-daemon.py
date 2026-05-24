#!/usr/bin/env python3
"""
mpd-lyrics daemon
- Watches MPD for song changes
- Fetches synced (.lrc) or plain lyrics from lrclib.net
- Caches lyrics in ~/.cache/mpd-lyrics/<artist>-<title>.lrc
- Writes current lyric line to /tmp/mpd-lyric-current for waybar
- Also writes .lrc next to music file for rmpc lyrics tab
"""

import os
import re
import time
import json
import unicodedata
import urllib.request
import urllib.parse
import socket

CACHE_DIR = os.path.expanduser("~/.cache/mpd-lyrics")
MUSIC_DIR = "/home/yugg755/Music"
CURRENT_FILE = "/tmp/mpd-lyric-current"
MPD_HOST = os.environ.get("MPD_HOST", "127.0.0.1")
MPD_PORT = int(os.environ.get("MPD_PORT", "6600"))
POLL_INTERVAL = 0.5


# ── MPD socket helpers ────────────────────────────────────────────────────────

def mpd_connect():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((MPD_HOST, MPD_PORT))
    s.recv(1024)
    return s

def mpd_cmd(s, cmd):
    s.sendall((cmd + "\n").encode())
    resp = b""
    while True:
        chunk = s.recv(4096)
        resp += chunk
        if b"\nOK\n" in resp or b"\nACK " in resp or resp.endswith(b"OK\n"):
            break
    return resp.decode(errors="replace")

def parse_mpd_response(text):
    result = {}
    for line in text.splitlines():
        if ": " in line:
            k, v = line.split(": ", 1)
            result[k] = v
    return result

def get_current_song(s):
    raw = mpd_cmd(s, "currentsong")
    info = parse_mpd_response(raw)
    raw2 = mpd_cmd(s, "status")
    status = parse_mpd_response(raw2)
    return info, status


# ── Lyrics cache helpers ──────────────────────────────────────────────────────

def safe_filename(s):
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode()
    s = re.sub(r"[^\w\s-]", "", s).strip().lower()
    return re.sub(r"[\s]+", "_", s)

def cache_path(artist, title):
    os.makedirs(CACHE_DIR, exist_ok=True)
    key = safe_filename(f"{artist}-{title}")
    return os.path.join(CACHE_DIR, key + ".lrc")

def cache_path_plain(artist, title):
    os.makedirs(CACHE_DIR, exist_ok=True)
    key = safe_filename(f"{artist}-{title}")
    return os.path.join(CACHE_DIR, key + ".txt")


# ── lrclib.net fetcher ────────────────────────────────────────────────────────

def fetch_lyrics(artist, title, album="", duration=None):
    params = {"artist_name": artist, "track_name": title}
    if album:
        params["album_name"] = album
    if duration:
        params["duration"] = int(float(duration))

    url = "https://lrclib.net/api/get?" + urllib.parse.urlencode(params)
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "mpd-lyrics-waybar/1.0"})
        with urllib.request.urlopen(req, timeout=8) as r:
            data = json.loads(r.read().decode())
        synced = data.get("syncedLyrics", "").strip()
        plain  = data.get("plainLyrics", "").strip()
        return synced or None, plain or None
    except Exception as e:
        print(f"[lyrics] fetch error: {e}")
        return None, None

def load_or_fetch(artist, title, album="", duration=None):
    lrc_file = cache_path(artist, title)
    txt_file = cache_path_plain(artist, title)

    if os.path.exists(lrc_file):
        with open(lrc_file) as f:
            content = f.read().strip()
        if content and content != "NONE":
            return "synced", content

    if os.path.exists(txt_file):
        with open(txt_file) as f:
            content = f.read().strip()
        if content and content != "NONE":
            return "plain", content

    synced, plain = fetch_lyrics(artist, title, album, duration)

    if synced:
        with open(lrc_file, "w") as f:
            f.write(synced)
        return "synced", synced

    if plain:
        with open(txt_file, "w") as f:
            f.write(plain)
        return "plain", plain

    with open(lrc_file, "w") as f:
        f.write("NONE")
    return None, None


# ── Write lrc next to music file for rmpc ────────────────────────────────────

def write_lrc_for_rmpc(music_file, lyrics_content):
    if not music_file:
        return
    music_path = os.path.join(MUSIC_DIR, music_file)
    lrc_path = os.path.splitext(music_path)[0] + ".lrc"
    if not os.path.exists(lrc_path):
        try:
            with open(lrc_path, "w") as f:
                f.write(lyrics_content)
            print(f"[mpd-lyrics] wrote lrc to {lrc_path}")
        except Exception as e:
            print(f"[mpd-lyrics] could not write lrc: {e}")


# ── LRC parser ────────────────────────────────────────────────────────────────

def parse_lrc(lrc_text):
    entries = []
    pattern = re.compile(r"\[(\d+):(\d+(?:\.\d+)?)\](.*)")
    for line in lrc_text.splitlines():
        m = pattern.match(line.strip())
        if m:
            minutes = int(m.group(1))
            seconds = float(m.group(2))
            text = m.group(3).strip()
            entries.append((minutes * 60 + seconds, text))
    entries.sort(key=lambda x: x[0])
    return entries

def current_lrc_line(entries, elapsed):
    current = ""
    for ts, text in entries:
        if ts <= elapsed:
            current = text
        else:
            break
    return current


# ── Plain lyrics cycling ──────────────────────────────────────────────────────

class PlainCycler:
    def __init__(self, text, seconds_per_line=3):
        self.lines = [l for l in text.splitlines() if l.strip()]
        self.spl = seconds_per_line
        self.start = time.time()

    def current(self):
        if not self.lines:
            return ""
        idx = int((time.time() - self.start) / self.spl) % len(self.lines)
        return self.lines[idx]


# ── Write current line ────────────────────────────────────────────────────────

def write_current(line):
    with open(CURRENT_FILE, "w") as f:
        f.write(line)


# ── Main loop ─────────────────────────────────────────────────────────────────

def main():
    os.makedirs(CACHE_DIR, exist_ok=True)
    write_current("")

    last_song_id = None
    lyrics_type = None
    lyrics_content = None
    lrc_entries = []
    plain_cycler = None
    artist = ""
    title = ""

    print("[mpd-lyrics] starting daemon...")

    while True:
        try:
            s = mpd_connect()
            while True:
                info, status = get_current_song(s)

                state = status.get("state", "stop")
                song_id = info.get("Id", "")
                elapsed = float(status.get("elapsed", 0))

                if state != "play":
                    write_current("")
                    time.sleep(POLL_INTERVAL)
                    continue

                # New song detected
                if song_id != last_song_id:
                    last_song_id = song_id
                    artist = info.get("Artist", info.get("AlbumArtist", ""))
                    title  = info.get("Title", os.path.basename(info.get("file", "")))
                    album  = info.get("Album", "")
                    duration = status.get("duration", None)
                    music_file = info.get("file", "")

                    print(f"[mpd-lyrics] now playing: {artist} - {title}")
                    write_current(f"{artist} - {title}")
                    lyrics_type, lyrics_content = load_or_fetch(artist, title, album, duration)

                    if lyrics_type == "synced":
                        lrc_entries = parse_lrc(lyrics_content)
                        plain_cycler = None
                        print(f"[mpd-lyrics] synced lyrics loaded ({len(lrc_entries)} lines)")
                        write_lrc_for_rmpc(music_file, lyrics_content)
                    elif lyrics_type == "plain":
                        lrc_entries = []
                        plain_cycler = PlainCycler(lyrics_content)
                        print("[mpd-lyrics] plain lyrics loaded")
                    else:
                        lrc_entries = []
                        plain_cycler = None
                        print("[mpd-lyrics] no lyrics found")

                # Write current line
                if lyrics_type == "synced" and lrc_entries:
                    line = current_lrc_line(lrc_entries, elapsed)
                    write_current(line)
                elif lyrics_type == "plain" and plain_cycler:
                    write_current(plain_cycler.current())
                else:
                    write_current(f"{artist} - {title}")

                time.sleep(POLL_INTERVAL)

        except (ConnectionRefusedError, OSError) as e:
            print(f"[mpd-lyrics] MPD connection lost: {e}. Retrying in 5s...")
            write_current("")
            time.sleep(5)
        except Exception as e:
            print(f"[mpd-lyrics] unexpected error: {e}. Retrying in 5s...")
            time.sleep(5)


if __name__ == "__main__":
    main()
