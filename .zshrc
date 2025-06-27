# Completions
zstyle ':completion:*' completer _expand _complete _ignored _correct 
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format '%B%F{green}[ %d ]%f%k%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/elliot/.zshrc'

autoload -Uz compinit
compinit

# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
unsetopt beep extendedglob notify
# bindkey -v
# End of lines configured by zsh-newuser-install

# Vim-mode improvements
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Fish-like autocompletion (using history)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
else
    echo "BTW: zsh-autosuggestions not installed"
fi

# Navigate autosuggestions using vim keys
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=bold
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
else
    echo "BTW: zsh-syntax-highlighting not installed"
fi

setopt hist_verify
setopt histignoredups
bindkey ' ' magic-space

bindkey '^L' autosuggest-accept

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
		echo ' : %B%F{yellow}'$branch' %f%b'
    elif [[ $commit != "" ]]; then
		echo ' : %B%F{yellow}'$commit' %f%b'
    fi
}

function prompt_path() {
	echo '%B%F{green}'$(path_to_git_root)'%f%b'
}

function pyvenv_name() {
	echo '%B%F{green}'$(path_to_git_root)'%f%b'
}

setopt prompt_subst

# Add newline before all prompts except the first one
# precmd() { precmd() { print "" } }
PROMPT='$(prompt_path)$(prompt_git_branch) %F{blue}󰣇%f '
RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'

# Moar colours!
eval "$(dircolors -b)"
export LS_COLORS="$LS_COLORS:ow=30;44:" # ls color for folders with 777 permissions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# better cd
export FZF_DEFAULT_COMMAND="find"
export FZF_DEFAULT_OPTS="--layout=reverse --height=40% --inline-info --border"
alias cdi='cd "./$(fd -Ht d 2>/dev/null | fzf)"'

# ls/eza aliases
alias ls='exa --group-directories-first'
alias li='exa -l --group-directories-first'
alias la='exa -la --group-directories-first'
alias lt='exa --tree'
# lt() {
# 	if [ ${1} -ge 48 && ${1} -lt 58 ]; then
# 		exa --tree -L $1
# 	else
# 		exa --tree
# 	fi
# }

# other aliases
alias vim=nvim
alias dotfiles='/usr/bin/git --git-dir ~/.dotfiles/ --work-tree ~'
alias matrix='unimatrix --speed=95 --character-list=k --color=green'
alias mkdir='mkdir -p'
mkcd() {
	mkdir -p $1
	cd $1
}
alias please=sudo
alias img=qimgv
alias history="history 0"

# Tetris lol
# autoload -Uz tetriscurses

calc() {
    python3 -c "from math import *; print($1)"
}
