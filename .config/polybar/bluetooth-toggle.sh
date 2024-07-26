#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
    rfkill unblock bluetooth
else
    rfkill block bluetooth
fi
