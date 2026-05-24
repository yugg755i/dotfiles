#!/bin/bash

current=$(mpc current)

# file to store last song
cache="/tmp/mpd_last_song"

# if same song as before → do nothing
if [ -f "$cache" ] && grep -Fxq "$current" "$cache"; then
    exit 0
fi
 
# save new song
echo "$current" > "$cache"

# notify
if [[ -n "$current" ]]; then
    notify-send -u low -t 2000 "$current"
fi
