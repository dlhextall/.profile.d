# OSX bash completion via homebrew
if hash brew 2>/dev/null; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	elif [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
		. $(brew --prefix)/share/bash-completion/bash_completion
	fi
fi
# *NIX bash completion
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# fuzzy finder
# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# For tmux
export SHELL=$( which bash )
# Git values
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
# Bash colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS='di=1;36:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34;43'
# Use vim as the default editor
export EDITOR=vim
# This file's location
export PROFILE_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Ignore duplicates in bash history
export HISTCONTROL="erasedups:ignoreboth"
# Record the history right away (instead of at the end of the session)
export PROMPT_COMMAND='history -a'
# Correct minor spelling mistakes
shopt -s cdspell
shopt -s dirspell

# Functions included in this library
for f in $PROFILE_LOCATION/functions/*.sh; do
	[[ ! -x $f ]] && source $f
done

# Machine-specific .profile
for f in ~/.profile.*; do
	[[ -a $f && -f $f ]] && source $f
done

# .config files
if [ "$( ls -l ~/.config/ | wc -l )" -lt "$( ls -l $PROFILE_LOCATION/.config/ | wc -l )" ]; then
	echo "There seems to be missing some config files in your ~/.config directory."
	echo "To add those in $PROFILE_LOCATION, type:"
	echo "ln -s $PROFILE_LOCATION/.config/* .config/"
fi

# General aliases
alias ..="cd .."
alias ...="cd ../.."
if ls --color &>/dev/null; then
	alias ls="ls --color"
fi
alias ll="ls -lah"
alias fork="fork open"
alias prev="open -a Preview"
alias tree="tree -C"

export PATH=$PROFILE_LOCATION/functions:~/.bin:/usr/local/bin:/usr/local/sbin:$PATH
if hash direnv 2>/dev/null; then
	eval "$(direnv hook bash)"
fi
# Set PS1 with git if available
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
	export PS1="\u \$ "
else
	ps1_var="\[\e[1m\]\u"
	if hash __git_ps1 2>/dev/null; then
		ps1_var="$ps1_var\$(__git_ps1)"
	fi
	export PS1="$ps1_var \$ \[\e[0m\]"
	export PROMPT_COMMAND="$PROMPT_COMMAND"'; set-title $( dirs -0 )'
fi
