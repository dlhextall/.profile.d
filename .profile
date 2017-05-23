if hash brew 2>/dev/null; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	elif [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
		. $(brew --prefix)/share/bash-completion/bash_completion
	fi
else
	if ! shopt -oq posix; then
	  if [ -f /usr/share/bash-completion/bash_completion ]; then
	    . /usr/share/bash-completion/bash_completion
	  elif [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
	  fi
	fi
fi

export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS='di=1;36:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34;43'
export EDITOR=vim
export PROFILE_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HISTCONTROL=ignoreboth

for f in $PROFILE_LOCATION/*.sh; do
	if [[ ! -x $f ]]; then
		source $f
	fi
done

for f in ~/.profile.*; do
	if [[ -a $f ]]; then
		source $f
	fi
done

alias ..="cd .."
alias ...="cd ../.."
if ls --color 2>/dev/null; then
	alias ls="ls --color"
fi
alias ll="ls -lah"
alias fork="fork open"
alias prev="open -a Preview"
alias tree="tree -C"

export PATH=$PROFILE_LOCATION:~/bin:/usr/local/bin:/usr/local/sbin:$PATH
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
	export PS1="\u \$ "
else
	if hash __git_ps1 2>/dev/null; then
		export PS1="\u\$(__git_ps1) \$ "
	fi
	trap 'set-title $( dirs -0 )' DEBUG
fi
