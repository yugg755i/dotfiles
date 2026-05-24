#!/usr/bin/env bash

HIDE_FILE="/tmp/waybar-lyrics-hidden"

if [[ -f "$HIDE_FILE" ]]; then
    rm "$HIDE_FILE"
else
    touch "$HIDE_FILE"
fi
