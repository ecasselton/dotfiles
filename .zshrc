[ -f "$HOME/.zalias" ] && source "$HOME/.zalias"

zmodload zsh/complist
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# zstyle ':completion:*' completer _expand _complete _ignored _correct 
# zstyle ':completion:*' expand prefix suffix
# zstyle ':completion:*' format '%B%F{cyan}[ %d ]%f%k%b'
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

zstyle ':completion:*' menu select 
zstyle ':completion:*' ignore-parents pwd # ignore cwd when completing cd ../
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
# zstyle ':completion:*' file-list true # More detailed completion list

HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
# history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt append_history inc_append_history share_history
setopt autocd
setopt nomatch
setopt interactive_comments # Allow comments in interactive shell
# setopt no_case_glob # Case insensitive completion
setopt prompt_subst
setopt hist_verify
setopt histignoredups
setopt nobeep
setopt globdots
# setopt auto_remove_slash

bindkey -e
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey ' ' magic-space
bindkey '^L' autosuggest-accept

# Fish-like autocompletion (using history)
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green
# ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
# ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green
ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=magenta
ZSH_HIGHLIGHT_STYLES[autodirectory]=underline
# ZSH_HIGHLIGHT_STYLES[path]=underline
# ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
# ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[redirection]=fg=magenta
ZSH_HIGHLIGHT_STYLES[comment]=fg=8
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

# ======= Prompt stuff =======
function path_to_git_root() {
	parentdir=$(git rev-parse --show-toplevel | rev | cut -d '/' -f 1 | rev)
	prefix=$(git rev-parse --show-prefix)
	if [ $prefix ]; then
		echo "$parentdir/${prefix:0:${#prefix}-1}"
	else
		echo "$parentdir"
	fi
}

function prompt_git_branch() {
	branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
	commit=$(git rev-parse HEAD 2> /dev/null | cut -c1-7)
	if [[ $branch != "" ]]; then
		echo $branch'  '
	elif [[ $commit != "" ]]; then
		echo $commit'  '
	fi
}

function prompt_path() {
	if git rev-parse --is-inside-work-tree &> /dev/null; then
		echo $(path_to_git_root)
	else
		echo "%~"
	fi
}

# Add newline before all prompts except the first one
# precmd() { precmd() { print "" } }
PROMPT='%F{green}$(prompt_path) %F{red}$(prompt_git_branch)%F{white}$%f '
RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
