#!/bin/bash

CSS="$HOME/.config/micro/micro-colors.css"
OUT="$HOME/.config/micro/colorschemes/matugen.micro"

get_color() {
    grep "@define-color $1 " "$CSS" | awk '{print $3}' | tr -d ';'
}

BACKGROUND=$(get_color background)
FOREGROUND=$(get_color on_background)
PRIMARY=$(get_color primary)
SECONDARY=$(get_color secondary)

cat > "$OUT" <<EOF
color-link default "$FOREGROUND,$BACKGROUND"
color-link comment "$SECONDARY"
color-link identifier "$FOREGROUND"
color-link statement "$PRIMARY"
color-link symbol "$PRIMARY"
color-link preproc "$SECONDARY"
color-link type "$PRIMARY"
color-link constant "$SECONDARY"
color-link special "$PRIMARY"
color-link statusline "$BACKGROUND,$PRIMARY"
color-link tabbar "$FOREGROUND,$BACKGROUND"
color-link line-number "$SECONDARY"
color-link current-line-number "$PRIMARY"
EOF
