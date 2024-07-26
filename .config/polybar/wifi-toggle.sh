#!/bin/sh

if [ $(nmcli | grep "wlp0s20f3: connected" | wc -c) -eq 0 ]
then
    rfkill unblock wlan
else
    rfkill block wlan
fi
