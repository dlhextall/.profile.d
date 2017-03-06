if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR=vim
export PROFILE_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
	export PS1="> "
else
	export PS1="[ \u@\h:\W\$(__git_ps1) ] $ "
fi

for f in $PROFILE_LOCATION/*.sh; do
	if [[ ! -x $f ]]; then
		source $f
	fi
done

alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias fork="fork open"
alias prev="open -a Preview"
alias tree="tree -C"

for f in ~/.profile.*; do
	if [[ -a $f ]]; then
		source $f
	fi
done

export PATH=$PROFILE_LOCATION:/usr/local/bin:/usr/local/sbin:$PATH
