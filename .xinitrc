#!/bin/sh
# if [ -e /sbin/prime-offload ]; then
    # echo running NVIDIA Prime setup /sbin/prime-offload
    # /sbin/prime-offload
# fi

# Configure touchpad
# Disable lock when type
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Tapping Enabled" 1
# Tapping
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Tapping Enabled" 1
# Natural scrolling
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Natural Scrolling Enabled" 1
# Pointer speed
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Accel Speed" 0.5 

. /etc/X11/Xsession

# picom -b
# exec i3
