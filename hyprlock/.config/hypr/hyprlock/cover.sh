#!/usr/bin/env bash

PLAYER_STATUS=$(playerctl -s status)

if [[ -z "$PLAYER_STATUS" ]]; then
  echo ''
  exit 0
fi

COVER_URL=$(playerctl metadata --format "{{ mpris:artUrl }}" 2>/dev/null | sed 's/b273/1e02/')
CONFIG_DIR="$HOME/.config/hypr"
COVER_ART_PNG="$CONFIG_DIR/coverart.png"
COVER_ART_JPG="$CONFIG_DIR/coverart.jpg"
INFO_FILE="$CONFIG_DIR/info.txt"

current_artist=$(playerctl metadata --format "{{ artist }}" 2>/dev/null)
current_title=$(playerctl metadata --format "{{ title }}" 2>/dev/null)
current_song="$current_artist - $current_title"
last_song=""

if [[ -f "$INFO_FILE" ]]; then
  last_song=$(cat "$INFO_FILE")
fi

if [[ "$current_song" != "$last_song" ]]; then
  echo "$current_song" >"$INFO_FILE"

  wget -q -O "$COVER_ART_PNG" "$COVER_URL"
  magick "$COVER_ART_PNG" "$COVER_ART_JPG"
fi

echo "$COVER_ART_JPG"
exit
