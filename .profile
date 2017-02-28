if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="[ \u@\h:\W\$(__git_ps1) ] $ "
export EDITOR=vim

for f in ~/.bin/*.sh; do
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

export PATH=~/.bin:/usr/local/bin:/usr/local/sbin:$PATH
