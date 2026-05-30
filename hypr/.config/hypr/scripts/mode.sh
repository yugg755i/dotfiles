#!/usr/bin/env bash

MODE=$(cat ~/.config/hypr/modes/current_mode 2>/dev/null)

case "$MODE" in
    forest) ICON="~ " ;;
    rain)   ICON=" " ;;
    night)  ICON="󰖔 " ;;
    dawn)   ICON="󰼰 " ;;
    fog)    ICON=" " ;;
    *)      ICON="  " ;;
esac

echo "{\"text\":\"$ICON\", \"tooltip\":\"Current mode: $MODE\"}"
