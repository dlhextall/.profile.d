if hash brew 2>/dev/null; then
	# OSX bash completion via homebrew
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	elif [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
		. $(brew --prefix)/share/bash-completion/bash_completion
	fi
else
	# *NIX bash completion
	if ! shopt -oq posix; then
	  if [ -f /usr/share/bash-completion/bash_completion ]; then
	    . /usr/share/bash-completion/bash_completion
	  elif [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
	  fi
	fi
fi

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
	if [[ ! -x $f ]]; then
		source $f
	fi
done

# Machine-specific .profile
for f in ~/.profile.*; do
	if [[ -a $f && -f $f ]]; then
		source $f
	fi
done

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

export PATH=$PROFILE_LOCATION/functions:~/bin:/usr/local/bin:/usr/local/sbin:$PATH
# Set PS1 with git if available
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
	export PS1="\u \$ "
else
	if hash __git_ps1 2>/dev/null; then
		export PS1="\u\$(__git_ps1) \$ "
	else
		export PS1="\u \$ "
	fi
	export PROMPT_COMMAND="$PROMPT_COMMAND"'; set-title $( dirs -0 )'
fi
