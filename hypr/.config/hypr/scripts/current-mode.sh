#!/bin/bash

MODE=$(cat ~/.config/hypr/modes/current_mode 2>/dev/null)

case "$MODE" in
    forest)
        TEXT="󱢅 Evergreen"
        ;;
    rain)
        TEXT=" Rainsong"
        ;;
    night)
        TEXT="󰖔 Nocturne"
        ;;
    dawn)
        TEXT="󰼰 Golden Hour"
        ;;
    fog)
        TEXT=" Mistveil"
        ;;
    *)
        TEXT="Unknown"
        ;;
esac

echo "{\"text\":\"$TEXT\",\"tooltip\":\"Current mode: $MODE\"}"
