#!/bin/bash

STATE_FILE="/tmp/focus-mode.state"

activate() {
  touch "$STATE_FILE"
  swaync-client --dnd-on
  hyprctl eval '
  hl.config({
    general = {
      gaps_in = 0,
      gaps_out = 0,
      border_size = 0.5,
    },
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
  grep -q 'alpha(@surface, 0.78)' ~/.config/waybar/style.css &&
    sed -i 's/background-color: alpha(@surface, 0\.78);/background-color: @surface;/' ~/.config/waybar/style.css
  pkill waybar
  waybar &
}

deactivate() {
  rm -f "$STATE_FILE"
  swaync-client --dnd-off
  hyprctl eval '
  hl.config({
    general = {
      gaps_in = 3,
      gaps_out = 5,
      border_size = 1
    },
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
  grep -q 'background-color: @surface;' ~/.config/waybar/style.css &&
    sed -i 's/background-color: @surface;/background-color: alpha(@surface, 0.78);/' ~/.config/waybar/style.css
  pkill waybar
  waybar &
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
