#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

# if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#   [ -x "$f" ] && . "$f"
#  done
#  unset f
# fi

# Configure touchpad
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Tapping Enabled" 1 # Tapping
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Disable While Typing Enabled" 0 # Disable lock when type
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Natural Scrolling Enabled" 1 # Natural scrolling
xinput set-prop "VEN_06CB:00 06CB:CE8C Touchpad" "libinput Accel Speed" 0.5 # Pointer speed

exec i3
