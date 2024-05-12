#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload xworkspaces &
    MONITOR=$m polybar --reload datetime &
    MONITOR=$m polybar --reload media &
    MONITOR=$m polybar --reload battery &
    MONITOR=$m polybar --reload network &
    MONITOR=$m polybar --reload xwindow &
  done
else
  polybar --reload xworkspaces &
  polybar --reload datetime &
  polybar --reload media &
  polybar --reload battery &
  polybar --reload network &
  polybar --reload xwindow &
fi

polybar --reload systray &

echo "Bars launched..."
