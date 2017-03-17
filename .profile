if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR=vim
export PROFILE_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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
alias ll="ls -lah"
alias fork="fork open"
alias prev="open -a Preview"
alias tree="tree -C"

export PATH=$PROFILE_LOCATION:/usr/local/bin:/usr/local/sbin:$PATH
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
	export PS1="\u \$ "
else
	export PS1="\u\$(__git_ps1) \$ "
	trap 'set-title $( dirs -0 )' DEBUG
fi
