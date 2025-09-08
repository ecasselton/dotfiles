# Source /etc/profile
. /etc/profile

connector=$(/usr/bin/proptest | grep DP-5 | cut -d' ' -f 2)
if [ "$(echo connector | wc -w)" -gt 0 ]; then
	connector=$(/usr/bin/proptest | grep DP-6 | cut -d' ' -f 2)
fi
/usr/bin/proptest -M i915 -D /dev/dri/card0 $connector connector 266 1

# include .zshrc if it exists
if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# if [ $(tty) = /dev/tty1 ] ; then
#     exec startx
# fi
