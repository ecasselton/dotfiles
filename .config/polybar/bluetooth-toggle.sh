#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  bluetoothctl power on
  echo 1 > /home/elliot/.config/polybar/bluetooth/powered
else
  bluetoothctl power off
  echo 0 > /home/elliot/.config/polybar/bluetooth/powered
  echo 0 > /home/elliot/.config/polybar/bluetooth/connected
fi
