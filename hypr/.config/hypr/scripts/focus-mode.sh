#!/bin/bash
STATE_FILE="/tmp/focus-mode.state"
WAYBAR_DIR="$HOME/.config/waybar"

activate() {
  touch "$STATE_FILE"
  swaync-client --dnd-on
  hyprctl eval '
  hl.config({
    animations = {
      enabled = false,
    },
    decoration = {
      blur = { enabled = false },
      shadow = { enabled = false },
      dim_inactive = false,
      active_opacity = 1.0,
      inactive_opacity = 1.0,
    }
  })
  '
  pkill -x waybar
  waybar \
    -c "$WAYBAR_DIR/themes/minimal-style/config.jsonc" \
    -s "$WAYBAR_DIR/themes/minimal-style/style.css" \
    >/dev/null 2>&1 &
  disown
}

deactivate() {
  rm -f "$STATE_FILE"
  swaync-client --dnd-off
  hyprctl eval '
  hl.config({
    animations = {
      enabled = true
    },
    decoration = {
      blur = { enabled = true },
      shadow = { enabled = false },
      dim_inactive = true,
      dim_strength = 0.08,
      active_opacity = 0.93,
      inactive_opacity = 0.88,
    }
  })
  '
  pkill -x waybar
  waybar \
    -c "$WAYBAR_DIR/config.jsonc" \
    -s "$WAYBAR_DIR/style.css" \
    >/dev/null 2>&1 &
  disown
}

case "$1" in
activate) activate ;;
deactivate) deactivate ;;
toggle)
  if [ -f "$STATE_FILE" ]; then
    deactivate
  else
    activate
  fi
  ;;
esac
