#!/usr/bin/env bash

PLAYER_STATUS=$(playerctl -s status)

if [[ -z "$PLAYER_STATUS" ]]; then
  echo ''
  exit 0
fi

CONFIG_DIR="$HOME/.config/hypr"
INFO_FILE="$CONFIG_DIR/info.txt"

cat "$INFO_FILE"
exit
