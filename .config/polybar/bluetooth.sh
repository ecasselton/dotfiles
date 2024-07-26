#!/usr/bin/env bash

connected=$(bluetoothctl info "50:C2:75:31:23:F6" | grep Connected | cut -d ' ' -f2)
powered=$(bluetoothctl show | grep Powered | cut -d ' ' -f2)

if [ $powered = "yes" ]; then
  if [ $connected = "yes" ]; then
    echo "  %{F#56949f} "
  fi
  echo "  %{F#cacad0} "
else
  echo "  %{F#707880}󰂲 "
fi

