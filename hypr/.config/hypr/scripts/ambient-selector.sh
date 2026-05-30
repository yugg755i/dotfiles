#!/bin/bash

MODE=$(cat ~/.config/hypr/modes/current_mode)

AMBIENCE_DIR="$HOME/.config/hypr/ambience/$MODE"

OPTIONS=$(ls "$AMBIENCE_DIR" | sed 's/.mp3//')

SELECTED=$(printf "%s\nstop ambience" "$OPTIONS" | rofi -dmenu -p "ambient")

if [[ "$SELECTED" == "stop ambience" ]]; then
    pkill mpv
    exit
fi

pkill mpv

mpv --no-video --loop-file=inf "$AMBIENCE_DIR/$SELECTED.mp3" &
