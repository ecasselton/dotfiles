# Source /etc/profile
. /etc/profile
/usr/bin/proptest -M i915 -D /dev/dri/card0 250 connector 245 1
/usr/bin/proptest -M i915 -D /dev/dri/card0 259 connector 245 1
#
# include .zshrc if it exists
if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# if [ $(tty) = /dev/tty1 ] ; then
#     exec startx
# fi
