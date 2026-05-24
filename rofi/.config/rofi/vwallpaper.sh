#!/usr/bin/env bash
export PATH="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
WALL_DIR="$HOME/Pictures/Wallpapers"

SELECTED=$(
  find "$WALL_DIR" -type f \
    \( -iname "*.mp4" -o -iname "*.gif" -o -iname "*.webm" \) |
  while read -r vid; do
    printf "%s\n" "$(basename "$vid")"
  done |
  rofi -dmenu -i -p "Video Wallpaper" \
       -config "$HOME/.config/rofi/config.rasi"
)

[ -z "$SELECTED" ] && exit 0
SELECTED_PATH="$WALL_DIR/$SELECTED"

pkill mpvpaper || true
mpvpaper --auto-pause -o "no-audio loop hwdec=vaapi" eDP-1 "$SELECTED_PATH" &

# extract frame and run matugen
TMPIMG="/tmp/matugen-preview.png"
ffmpeg -y -i "$SELECTED_PATH" -frames:v 1 "$TMPIMG" 2>/dev/null
matugen image "$TMPIMG" -m dark -t scheme-neutral --prefer value

pkill waybar || true
waybar & disown
echo "$SELECTED_PATH" > ~/.config/hypr/current_video_wallpaper
