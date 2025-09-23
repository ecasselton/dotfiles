# Source /etc/profile
. /etc/profile

export QT_QPA_PLATFORMTHEME="qt6ct"
export ZDOTDIR="$HOME/.config/zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# . ~/.scripts/broadcast-rgb

if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.scripts:$HOME/.local/bin:$PATH"
fi

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
