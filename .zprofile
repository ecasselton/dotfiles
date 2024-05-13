if [ -n "$ZSH_VERSION" ]; then
    # include .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ] ; then
#     export PATH="$HOME/.local/bin:$PATH"
# fi

# set PATH to include system binaries
export PATH="/sbin:/usr/sbin:$PATH"
export QT_QPA_PLATFORMTHEME="qt5ct"
export SAL_USE_VCLPLUGIN="qt5"
export WINIT_X11_SCALE_FACTOR=1.5

if [ $(tty) = /dev/tty1 ] ; then
    exec startx
fi
