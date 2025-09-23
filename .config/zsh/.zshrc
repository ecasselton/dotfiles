[ -f "$XDG_CONFIG_HOME/zsh/.alias" ] && source "$XDG_CONFIG_HOME/zsh/.alias"

autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
# autoload -U tetris

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# zstyle ':completion:*' completer _expand _complete _ignored _correct 
# zstyle ':completion:*' expand prefix suffix
# zstyle ':completion:*' format '%B%F{cyan}[ %d ]%f%k%b'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' ignore-parents pwd
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' preserve-prefix '//[^/]##/'
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true
# zstyle :compinstall filename '/home/elliot/.zshrc'

zstyle ':completion:*' menu select
# zstyle ':completion:*' file-list true # More detailed completion list

HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
setopt nomatch
setopt interactive_comments # Allow comments in interactive shell
setopt no_case_glob # Case insensitive completion
setopt prompt_subst
setopt hist_verify
setopt histignoredups
setopt nobeep
setopt auto_param_slash

# Navigate autosuggestions using vim keys
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey ' ' magic-space
bindkey '^L' autosuggest-accept

# Vim mode
. /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Fish-like autocompletion (using history)
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=bold
ZSH_HIGHLIGHT_STYLES[path]=bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[redirection]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout


# ======= Prompt stuff =======
function path_to_git_root() {
	if git rev-parse --is-inside-work-tree &> /dev/null; then
		parentdir=$(git rev-parse --show-toplevel | rev | cut -d '/' -f 1 | rev)
		prefix=$(git rev-parse --show-prefix)
		if [ $prefix ]; then
			echo "$parentdir/${prefix:0:${#prefix}-1}"
			else
				echo "$parentdir"
		fi
	else
		echo "%~"
	fi
}

function prompt_git_branch() {
	branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
	commit=$(git rev-parse HEAD 2> /dev/null | cut -c1-7)
	if [[ $branch != "" ]]; then
		echo ' %F{red}'$branch' %f'
	elif [[ $commit != "" ]]; then
		echo ' %F{red}'$commit' %f'
	fi
}

function prompt_path() {
	echo '%F{green}'$(path_to_git_root)'%f'
}

function pyvenv_name() {
	echo '%F{yellow}'$(path_to_git_root)'%f'
}

# Add newline before all prompts except the first one
# precmd() { precmd() { print "" } }
PROMPT='$(prompt_path)$(prompt_git_branch) %F{blue}󰣇%f '
RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
