#!/usr/bin/env bash
set -euo pipefail

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/thumbnails/bgselector"
LOCK="/tmp/generate-thumbs.lock"

mkdir -p "$CACHE_DIR"

# refuse to run twice at once — this alone prevents pile-ups
exec 9>"$LOCK"
flock -n 9 || {
  echo "already running"
  exit 0
}

find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 |
  while IFS= read -r -d '' img; do
    name="$(basename "$img")"
    thumb="$CACHE_DIR/$name.png"
    [ -f "$thumb" ] && continue

    nice -n 19 ionice -c3 magick "$img" \
      -limit thread 1 -limit memory 256MiB -limit map 512MiB \
      -strip -thumbnail x540^ -gravity center -extent 229x540 \
      "$thumb"
  done
