#!/usr/bin/env bash

LYRIC_FILE="/tmp/mpd-lyric-current"

HIDE_FILE="/tmp/waybar-lyrics-hidden"

if [[ -f "$HIDE_FILE" ]]; then
    echo '{"text": "[ ♪ ]", "class": "lyrics-hidden"}'
    exit 0
fi

MAX_LEN=55

line=$(cat "$LYRIC_FILE" 2>/dev/null)

if [[ -z "$line" ]]; then
    echo '{"text": "", "class": "no-lyrics"}'
    exit 0
fi

if (( ${#line} > MAX_LEN )); then
    line="${line:0:$MAX_LEN}…"
fi

line_escaped=$(printf '%s' "$line" | sed 's/\\/\\\\/g; s/"/\\"/g')
text="<span color='#49454e'>[ </span><span color='#cec2db'>♪  ${line_escaped}</span><span color='#49454e'> ]</span>"

printf '{"text": "%s", "class": "has-lyrics", "tooltip": "%s"}\n' "$text" "$line_escaped"
