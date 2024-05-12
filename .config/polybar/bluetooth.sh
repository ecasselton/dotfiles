#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#707880}󰂲"
else
  if [ $(echo info | bluetoothctl | grep 'Jabra Elite 4' | wc -c) -eq 0 ]
  then 
    echo "%{F#cacad0}"
  fi
  echo "%{F#56949f}"
fi
