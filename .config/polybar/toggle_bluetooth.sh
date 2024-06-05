#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  rfkill unblock bluetooth
  bluetoothctl power on
  printf 1 > /home/elliot/.config/polybar/bluetooth_on
else
  bluetoothctl power off
  rfkill block bluetooth
  printf 0 > /home/elliot/.config/polybar/bluetooth_on
fi
