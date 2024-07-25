#!/usr/bin/env bash

case x"$@" in
    x"shutdown")
        shutdown -h now &
        ;;
    x"suspend")
        loginctl lock-session && systemctl suspend && killall rofi
        ;;
    x"reboot")
        reboot
        ;;
    x"hibernate")
        systemctl hibernate
        ;;
esac

if [ x"$@" = x"shutdown" ] ; then
    shutdown -h now
fi

echo "shutdown"
echo "suspend"
echo "reboot"
echo "hibernate"
