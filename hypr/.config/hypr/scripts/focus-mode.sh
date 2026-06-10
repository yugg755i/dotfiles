#!/bin/bash

STATE_FILE="/tmp/focus-mode.state"

activate() {
  touch "$STATE_FILE"
  swaync-client --dnd-on
  hyprctl eval "hl.config({ general = { gaps_in = 0, gaps_out = 0 } })"
  hyprctl eval "hl.config({ animations = { enabled = false } })"
  hyprctl eval "hl.config({ decoration = {shadow = { enabled = false }, dim_inactive = false} })"
}

deactivate() {
  rm -f "$STATE_FILE"
  swaync-client --dnd-off
  hyprctl eval "hl.config({ general = { gaps_in = 3, gaps_out = 5 } })"
  hyprctl eval "hl.config({ animations = { enabled = true } })"
  hyprctl eval "hl.config({ decoration = { blur = { enabled = true }, shadow = { enabled = false }, dim_inactive = true, dim_strength = 0.08, active_opacity = 0.92, inactive_opacity = 0.88 } })"
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
