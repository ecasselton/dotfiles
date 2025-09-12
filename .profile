# Source /etc/profile
. /etc/profile

. ~/.scripts/broadcast-rgb

if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.scripts:$HOME/.local/bin:$PATH"
fi

# if [ $(tty) = /dev/tty1 ] ; then
#     exec startx
# fi
