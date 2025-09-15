#!/usr/bin/env bash

BAT_INFO=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

STATE=$(echo "$BAT_INFO" | grep "state: " | sed 's/ *state: *//')

if [[ "$STATE" == "fully-charged" ]]; then
  echo " 󱊣 Full"
  exit 0
fi

REMAINING=$(echo "$BAT_INFO" |
  grep "time to empty: " |
  sed 's/ *time to empty: *//')

ICON=" 󰁾 "

if [[ "$STATE" != "discharging" ]]; then
  # echo " 󱊣 Charging"
  REMAINING=$(echo "$BAT_INFO" |
    grep "time to full: " |
    sed 's/ *time to full: *//')
  ICON=" 󰂄 "
  # exit 0
fi

PERCENTAGE=$(echo "$BAT_INFO" |
  grep "percentage: " |
  sed 's/ *percentage: *\([[:digit:]]*\)%/\1 %/')

echo "$ICON$PERCENTAGE ($REMAINING)"
