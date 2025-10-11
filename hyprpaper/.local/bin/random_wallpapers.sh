#!/usr/bin/env bash

while ! pidof hyprpaper &>/dev/null; do
  sleep 1
done

sleep 1

ROOT_WALLPAPER_DIR="$HOME/.wallpapers/"
TYPE_WALLPAPER="${ROOT_WALLPAPER_DIR}$1/"
CURRENT_WALLPAPER=$(hyprctl hyprpaper listloaded)

if [[ -z "$1" && "$CURRENT_WALLPAPER" == "no wallpapers loaded" ]]; then
  TYPE_WALLPAPER="$(find "$ROOT_WALLPAPER_DIR" -maxdepth 1 -type d | tail -n +2 | shuf -n 1)/"
fi

if [[ -z "$1" && "$CURRENT_WALLPAPER" != "no wallpapers loaded" ]]; then
  TYPE_WALLPAPER="${ROOT_WALLPAPER_DIR}$(echo "$CURRENT_WALLPAPER" | awk 'BEGIN { FS = "/" } ; { print $5 }')/"
fi

WALLPAPER=$(find "$TYPE_WALLPAPER" -type f ! -name "$(basename "$CURRENT_WALLPAPER")" | shuf -n 1)

hyprctl hyprpaper reload ,"contain:$WALLPAPER"
