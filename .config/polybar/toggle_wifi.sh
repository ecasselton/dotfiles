#!/bin/sh

if [ $(nmcli | grep "wlp0s20f3: connected" | wc -c) -eq 0 ]
then
  nmcli connection up wifi-wlp0s20f3
else
  nmcli connection down wifi-wlp0s20f3
fi
