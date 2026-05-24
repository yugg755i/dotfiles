#!/usr/bin/env bash

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
mem_used=$(free -h | awk '/^Mem:/ {print $3}')
mem_total=$(free -h | awk '/^Mem:/ {print $2}')
disk=$(df -h / | awk 'NR==2 {print $5}')
uptime=$(uptime -p | sed 's/up //')

tooltip="cpu: ${cpu}%  |  mem: ${mem_used}/${mem_total}  |  disk: ${disk}  |  up: ${uptime}"

printf '{"text": "<span color='"'"'#968f8e'"'"' font_size='"'"'13pt'"'"'>   </span>", "tooltip": "%s"}\n' "$tooltip"
