#!/usr/bin/env bash

images=(~/pictures/wallpapers/gruvbox/*)
length=${#images[@]}

index=$((1 + $RANDOM % $length - 1))
echo $index

hyprctl hyprpaper preload ${images[$index]}
hyprctl hyprpaper wallpaper	",${images[$index]}"
