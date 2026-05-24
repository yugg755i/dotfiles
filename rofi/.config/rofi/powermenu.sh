#!/usr/bin/env bash

theme="/home/yugg755/.config/rofi/config.rasi"

chosen=$(echo -e "Lock\nLogout\nSuspend\nReboot\nShutdown" | rofi -dmenu -i -theme "$theme" -p "Power")

case "$chosen" in
    Lock)
       pkill ~/.config/rofi/powermenu.sh 
       hyprlock
        ;;
    Logout)
	loginctl terminate-session $XDG_SESSION_ID
        ;;
    Suspend)
        hyprlock & sleep 1 && systemctl suspend
        ;;
    Reboot)
       systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac
