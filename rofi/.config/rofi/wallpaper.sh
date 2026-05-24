#!/usr/bin/env bash
export PATH="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

WALL_DIR="$HOME/Pictures/Wallpapers"

# pick wallpaper with thumbnails
SELECTED=$(
  find "$WALL_DIR" -type f \
    \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" -o -iname "*.gif" \) |
  while read -r img; do
    name="$(basename "$img")"
    printf "%s\0icon\x1f%s\n" "$name" "$img"
  done |
  rofi -dmenu -i -p "" -show-icons \
       -config "$HOME/.config/rofi/config-wallpaper.rasi"
)

[ -z "$SELECTED" ] && exit 0

SELECTED_PATH="$WALL_DIR/$SELECTED"

# make sure awww daemon is running
if ! pgrep -x awww-daemon > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

# set wallpaper with transition
awww img "$SELECTED_PATH" \
    --transition-type wipe \
    --transition-duration 0.8 \
    --transition-angle 30 \
    --transition-fps 60

# update symlink for matugen
ln -sf "$SELECTED_PATH" ~/.config/hypr/current_wallpaper

# wait for wallpaper to finish setting before running matugen
sleep 0.5

# run matugen — use static image even if gif
if [[ "$SELECTED_PATH" == *.gif ]]; then
    # extract first frame for matugen
    TMPIMG="/tmp/matugen-preview.png"
    ffmpeg -y -i "$SELECTED_PATH" -frames:v 1 "$TMPIMG" 2>/dev/null
    matugen image "$TMPIMG" -m dark -t scheme-neutral --prefer value
else
    matugen image "$SELECTED_PATH" -m dark -t scheme-neutral --prefer darkness
fi

# reload waybar
pkill waybar || true
waybar &
disown
bash ~/.config/scripts/generate-micro-theme.sh
