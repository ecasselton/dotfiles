# Source /etc/profile
. /etc/profile

# include .zshrc if it exists
if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

if [ $(tty) = /dev/tty1 ] ; then
    exec startx
fi
