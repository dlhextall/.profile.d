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
# Add time to history command
export HISTTIMEFORMAT="%F %T "
# Record the history right away (instead of at the end of the session)
export PROMPT_COMMAND='history -a'
# Correct minor spelling mistakes
shopt -s cdspell
shopt -s dirspell
[[ ! -f ~/.inputrc ]] && echo "set completion-ignore-case On" >> ~/.inputrc

# Functions included in this library
for f in $PROFILE_LOCATION/functions/*.sh; do
    [[ ! -x $f ]] && source $f
done

export PATH=$(find $PROFILE_LOCATION/functions -type d | tr '\n' ':' | sed 's/:$//'):~/.bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$PATH

# General aliases
alias ..="cd .."
alias ...="cd ../.."
ls --color &>/dev/null && alias ls="ls --color"
alias ll="ls -lah"
alias tree="tree -C"
function mkcd() {
    ## Shell scripts are run in a subshell, so the cd command would never work in an external function
    mkdir -p "$1" && cd "$_"
}

# MacOS-specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias prev="open -a Preview"
    alias screensaver="open -a ScreenSaverEngine"
fi

# Machine-specific .profile
for f in ~/.profile.*; do
    [[ -f $f ]] && source $f
done

# .config files
if [ "$( ls ~/.config/ | wc -l )" -lt "$( ls $PROFILE_LOCATION/.config/ | wc -l )" ]; then
    echo "There seems to be missing some config files in your ~/.config directory."
    echo "To add those in $PROFILE_LOCATION, type:"
    echo "ln -s $PROFILE_LOCATION/.config/* .config/"
fi

# direnv
# https://direnv.net/
hash direnv 2>/dev/null && eval "$(direnv hook bash)"

# fuzzy finder
# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# thefuck
# https://github.com/nvbn/thefuck
hash thefuck 2>/dev/null && eval $( thefuck --alias )

# rvm
# https://rvm.io/
[ -f ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm

# Set PS1 with git if available
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
    export PS1="\u \$ "
else
    ps1_var="\[\e[1m\]\u"
    hash __git_ps1 2>/dev/null && ps1_var="$ps1_var\$(__git_ps1)"
    export PS1="$ps1_var \$ \[\e[0m\]"
    export PROMPT_COMMAND="$PROMPT_COMMAND"'; set-title $( dirs -0 )'
fi
