#!/usr/bin/env bash

# --- Configuration & Paths ---
ROOT="$HOME/Movies"
CACHE_DIR="$HOME/.cache/moviepicker"
LAST_LOC_FILE="$CACHE_DIR/last_location"
HISTORY_FILE="$CACHE_DIR/movie_history"

mkdir -p "$CACHE_DIR"
touch "$HISTORY_FILE"

# Extensions to recognize as valid video files
VIDEO_EXTS='(mkv|mp4|avi|webm|mov)'

# Restore last opened directory if it exists under ROOT, otherwise default to ROOT
if [[ -f "$LAST_LOC_FILE" ]]; then
  current=$(cat "$LAST_LOC_FILE")
  [[ ! -d "$current" || "$current" != "$ROOT"* ]] && current="$ROOT"
else
  current="$ROOT"
fi

# Helper function to check if a directory contains any valid video files recursively
has_videos() {
  find "$1" -type f -regextype posix-extended -iregex ".*\.${VIDEO_EXTS}$" -print -quit | grep -q .
}

# Main navigation loop
while true; do
  # Save the current location for the next launch
  echo "$current" >"$LAST_LOC_FILE"

  # Declare associative arrays to map display text back to real paths
  declare -A paths
  choices=()

  # --- 1. Global / Navigation Controls ---
  if [[ "$current" != "$ROOT" ]]; then
    choices+=("..")
    paths[".."]=".."
  fi

  # Root-level entry points for global options
  if [[ "$current" == "$ROOT" ]]; then
    choices+=(">> Search Entire Library" ">> Play Random Movie" ">> Recent Movies")
    paths[">> Search Entire Library"]="GLOBAL_SEARCH"
    paths[">> Play Random Movie"]="GLOBAL_RANDOM"
    paths[">> Recent Movies"]="GLOBAL_RECENT"
  fi

  # --- 2. Read Directories (Sorted Naturally) ---
  while IFS= read -r item; do
    [[ -z "$item" ]] && continue
    # Optimization: Only show folders containing video files
    if has_videos "$item"; then
      name=$(basename "$item")
      display="[DIR] $name"
      choices+=("$display")
      paths["$display"]="$item"
    fi
  done < <(find "$current" -maxdepth 1 -mindepth 1 -type d | sort -V)

  # --- 3. Read Files (Filtered & Sorted Naturally) ---
  while IFS= read -r item; do
    [[ -z "$item" ]] && continue
    name=$(basename "$item")

    # Strip the video extension for clean display
    display="${name%.*}"
    display="[VID] $display"

    choices+=("$display")
    paths["$display"]="$item"
  done < <(find "$current" -maxdepth 1 -mindepth 1 -type f -regextype posix-extended -iregex ".*\.${VIDEO_EXTS}$" | sort -V)

  # --- 4. Auto-Play Optimization ---
  # If we are inside a folder with exactly ONE sub-item and it's a video file, skip the menu
  if [[ "$current" != "$ROOT" && ${#choices[@]} -eq 2 && "${choices[0]}" == ".." && "${choices[1]}" == "[VID]"* ]]; then
    selection="${choices[1]}"
  else
    # Prompt the user via Rofi
    selection=$(printf "%s\n" "${choices[@]}" | rofi -theme "$HOME/.config/rofi/movies.rasi" -dmenu -i -p "Library")
  fi

  # Exit if user canceled or pressed Escape
  [[ -z "$selection" ]] && exit

  path="${paths[$selection]}"

  # --- 5. Action Handling ---
  case "$path" in
  "..")
    current=$(dirname "$current")
    continue
    ;;

  "GLOBAL_SEARCH")
    # Clear paths to rebuild them for global search results
    declare -A search_paths
    search_choices=()

    while IFS= read -r item; do
      [[ -z "$item" ]] && continue
      # Strip root path out for clean list display
      rel_path="${item#$ROOT/}"
      display="${rel_path%.*}"
      search_choices+=("$display")
      search_paths["$display"]="$item"
    done < <(find "$ROOT" -type f -regextype posix-extended -iregex ".*\.${VIDEO_EXTS}$" | sort -V)

    search_selection=$(printf "%s\n" "${search_choices[@]}" | rofi -theme "$HOME/.config/rofi/movies.rasi" -dmenu -i -p "Search All")
    [[ -z "$search_selection" ]] && continue

    final_path="${search_paths[$search_selection]}"
    ;;

  "GLOBAL_RANDOM")
    final_path=$(find "$ROOT" -type f -regextype posix-extended -iregex ".*\.${VIDEO_EXTS}$" | shuf -n1)
    [[ -z "$final_path" ]] && continue
    ;;

  "GLOBAL_RECENT")
    declare -A recent_paths
    recent_choices=()

    if [[ ! -s "$HISTORY_FILE" ]]; then
      rofi -e "No viewing history found."
      continue
    fi

    # Read history backward (most recent first)
    while IFS= read -r item; do
      [[ -z "$item" || ! -f "$item" ]] && continue
      display=$(basename "${item%.*}")
      # Deduplicate entries in the current display view
      if [[ -z "${recent_paths[$display]}" ]]; then
        recent_choices+=("$display")
        recent_paths["$display"]="$item"
      fi
    done < <(tac "$HISTORY_FILE")

    recent_selection=$(printf "%s\n" "${recent_choices[@]}" | rofi -theme "$HOME/.config/rofi/movies.rasi" -dmenu -i -p "Recent")
    [[ -z "$recent_selection" ]] && continue

    final_path="${recent_paths[$recent_selection]}"
    ;;

  *)
    final_path="$path"
    ;;
  esac

  # --- 6. Playback or Directory Change Execution ---
  if [[ -d "$final_path" ]]; then
    current="$final_path"
  elif [[ -f "$final_path" ]]; then
    # Log to recent history cache file
    echo "$final_path" >>"$HISTORY_FILE"

    # Run mpv with resume-playback enabled natively
    exec mpv --save-position-on-quit "$final_path"
  fi
done
