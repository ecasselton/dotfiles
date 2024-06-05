#!/usr/bin/env bash

status=$(</home/elliot/.config/polybar/bluetooth_on)
# echo "hi"

if [ "$status" -eq 0 ]; then
  echo "%{F#707880}󰂲"
else
  if [ "$status" -eq 1 ]
  then 
    echo "%{F#cacad0}"
  fi
  echo "%{F#56949f}"
fi
