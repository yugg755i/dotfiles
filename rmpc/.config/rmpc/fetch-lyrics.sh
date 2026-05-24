#!/usr/bin/env bash

FILE="$MUSIC_DIRECTORY/$FILE"
LRC="${FILE%.*}.lrc"

if [[ -f "$LRC" ]]; then
    exit 0
fi

lrcget get -o "$LRC" \
    --artist "$ARTIST" \
    --title "$TITLE" \
    --album "$ALBUM" \
    --duration "$DURATION"
