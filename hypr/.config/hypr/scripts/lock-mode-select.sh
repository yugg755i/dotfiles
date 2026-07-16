#!/usr/bin/env bash
export PATH="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
WALL_DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="$HOME/.config/hypr/lock_mode"
VIDEO_FILE="$HOME/.config/hypr/lock_video_path"

CHOICE=$(printf "Current Wallpaper\nLive Wallpaper" | rofi -dmenu -i -p "Lock Screen" -config "$HOME/.config/rofi/config.rasi")
[ -z "$CHOICE" ] && exit 0

if [ "$CHOICE" = "Current Wallpaper" ]; then
    echo "static" > "$STATE_FILE"
    notify-send "Lock Screen" "Set to current wallpaper"
    exit 0
fi

SELECTED=$(
  find "$WALL_DIR" -type f \
    \( -iname "*.mp4" -o -iname "*.gif" -o -iname "*.webm" \) |
  while read -r vid; do printf "%s\n" "$(basename "$vid")"; done |
  rofi -dmenu -i -p "Live Wallpaper" -config "$HOME/.config/rofi/config.rasi"
)
[ -z "$SELECTED" ] && exit 0

echo "live" > "$STATE_FILE"
echo "$WALL_DIR/$SELECTED" > "$VIDEO_FILE"
notify-send "Lock Screen" "Set to live: $SELECTED"
