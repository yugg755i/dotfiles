#!/usr/bin/env bash
export PATH="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
STATE_FILE="$HOME/.config/hypr/lock_mode"
VIDEO_FILE="$HOME/.config/hypr/lock_video_path"
STATIC_WALL="$HOME/.config/hypr/current_wallpaper"
DESKTOP_VIDEO_FILE="$HOME/.config/hypr/current_video_wallpaper"

MODE=$(cat "$STATE_FILE" 2>/dev/null || echo "static")

# was the desktop showing a live wallpaper? remember, then tear it down
WAS_LIVE=false
pgrep -x mpvpaper >/dev/null && WAS_LIVE=true
pkill mpvpaper-stop 2>/dev/null
pkill mpvpaper 2>/dev/null

if [ "$MODE" = "live" ] && [ -f "$VIDEO_FILE" ]; then
    VIDEO=$(cat "$VIDEO_FILE")
    swaylock-plugin --command "mpvpaper -o 'no-audio loop hwdec=vaapi-copy config=no' '*' '$VIDEO'"
else
    swaylock-plugin --command "swaybg -i '$STATIC_WALL' -m fill"
fi

# swaylock-plugin has exited (unlocked) — restore the desktop wallpaper
if [ "$WAS_LIVE" = true ] && [ -f "$DESKTOP_VIDEO_FILE" ]; then
    DVIDEO=$(cat "$DESKTOP_VIDEO_FILE")
    mpvpaper -o "no-audio loop hwdec=vaapi input-ipc-server=/tmp/mpvsocket config=no" eDP-1 "$DVIDEO" &
    mpvpaper-stop -f -p /tmp/mpvsocket &
fi
