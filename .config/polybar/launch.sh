#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar


killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload workspaces &
    MONITOR=$m polybar --reload time &
    MONITOR=$m polybar --reload date &
    MONITOR=$m polybar --reload sliders &
    MONITOR=$m polybar --reload else &
  done
else
  polybar --reload workspaces &
  polybar --reload time &
  polybar --reload date &
  polybar --reload sliders &
  polybar --reload else &
fi

polybar --reload systray &

echo "Bars launched..."
