#!/bin/sh
# Xsetup - run as root before the login dialog appears

# if [ -e /sbin/prime-offload ]; then
    # echo running NVIDIA Prime setup /sbin/prime-offload
    # /sbin/prime-offload
# fi

# Configure touchpad
# Tapping
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Tapping Enabled" 1
# Natural scrolling
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Natural Scrolling Enabled" 1
# Pointer speed
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Accel Speed" 0.5 

# exec ~/.xsession
exec i3 --shmlog-size=26214400

# Compositor
exec /usr/bin/picom -b

exec kglobalaccel5 &
