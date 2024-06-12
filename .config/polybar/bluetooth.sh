#!/usr/bin/env bash

powered=$(</home/elliot/.config/polybar/bluetooth/powered)
connected=$(</home/elliot/.config/polybar/bluetooth/connected)

if [ "$powered" -eq 1 ]; then
  if [ "$connected" -eq 1 ]; then
    echo "  %{F#56949f} "
  fi
  echo "  %{F#cacad0} "
else
  echo "  %{F#707880}󰂲 "
fi
