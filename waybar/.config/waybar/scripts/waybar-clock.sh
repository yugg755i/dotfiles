#!/usr/bin/env bash

time=$(date +'%H:%M %A, %b %d' | awk '{print tolower($0)}')
text="<span color='#49454e'>[ </span><span color='#cec2db'>${time}</span><span color='#49454e'> ]</span>"
printf '{"text": "%s"}\n' "$text"
