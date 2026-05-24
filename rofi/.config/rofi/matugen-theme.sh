#!/usr/bin/env bash
export PATH="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

wallpaper=$(readlink -f "$HOME/.config/hypr/current_wallpaper")

scheme=$(
    printf "content\ntonal-spot\nvibrant\nexpressive\nmonochrome\nneutral\nfidelity\nrainbow\nfruit-salad" |
    rofi -dmenu -p "Theme Style" \
    -config ~/.config/rofi/config.rasi
)
[ -z "$scheme" ] && exit 0

prefer=$(
    printf "darkness\nlightness\nsaturation\nless-saturation\nvalue\nclosest-to-fallback" |
    rofi -dmenu -p "Color Preference" \
    -config ~/.config/rofi/config.rasi
)
[ -z "$prefer" ] && exit 0

matugen image "$wallpaper" --type "scheme-$scheme" --prefer "$prefer"

notify-send "Matugen" "Applied $scheme ($prefer)"
