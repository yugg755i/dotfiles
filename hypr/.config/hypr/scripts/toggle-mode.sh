#!/usr/bin/env bash
export PATH="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export DISPLAY="${DISPLAY:-:0}"
export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(id -u)/bus}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

MODE_FILE="$HOME/.config/hypr/modes/current_mode"
WALL_DIR="$HOME/.config/hypr/modes/walls"


OPTIONS="󱢅 Evergreen
 Rainsong
󰖔 Nocturne
󰼰:Golden Hour
 Mistveil"

SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "moods")
[ -z "$SELECTED" ] && exit 0

case "$SELECTED" in
    "󱢅 Evergreen")   NEXT_MODE="forest" ;;
    " Rainsong")    NEXT_MODE="rain" ;;
    "󰖔 Nocturne")   NEXT_MODE="night" ;;
    "󰼰 Golden Hour") NEXT_MODE="dawn" ;;
    " Mistveil")    NEXT_MODE="fog" ;;
esac

echo "$NEXT_MODE" > "$MODE_FILE"

# find actual file regardless of extension
WALL=$(find "$WALL_DIR" -name "$NEXT_MODE.*" | head -1)

if ! pgrep -x awww-daemon > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

awww img "$WALL" \
    --transition-type wipe \
    --transition-duration 0.8 \
    --transition-angle 30 \
    --transition-fps 60

ln -sf "$WALL" ~/.config/hypr/current_wallpaper
sleep 0.5

matugen image "$WALL" -m dark -t scheme-neutral --prefer darkness
sleep 0.3

bash ~/.config/scripts/generate-micro-theme.sh
sleep 0.2

case "$NEXT_MODE" in
    forest)
        notify-send "󱢅 Evergreen" 
        ;;
    rain)
        notify-send " Rainsong"
        ;;
    night)
        notify-send "󰖔 Nocturne"
        ;;
    dawn)
        notify-send "󰼰 Golden Hour" 
        ;;
    fog)
        notify-send " Mistveil" 
        ;;
esac

pkill waybar || true
waybar >/dev/null 2>&1 &
disown

if [ -f "/tmp/focus-mode.state" ]; then
  bash ~/.config/hypr/scripts/focus-mode.sh activate
fi
