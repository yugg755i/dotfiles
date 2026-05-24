#!/bin/bash

if [ "$1" = "--status" ]; then
    tuned-adm active | awk -F': ' '{print $2}'
    exit 0
fi
current=$(tuned-adm active | awk -F': ' '{print $2}')

choice=$(echo -e "Performance\nBalanced\nPower Saver" | rofi -dmenu -p "Mode: $current")

notify-send "Power Mode" "$choice Activated"

case "$choice" in
  "Performance")
    sudo tuned-adm profile throughput-performance
    ;;
  "Balanced")
    sudo tuned-adm profile balanced
    ;;
  "Power Saver")
    sudo tuned-adm profile powersave
    ;;
esac
