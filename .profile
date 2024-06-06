# M1 Homebrew
if [[ $( uname -p ) == "arm" ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi

# OSX bash completion via homebrew
if hash brew 2>/dev/null; then
    [ -r $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
    [ -r $(brew --prefix)/share/bash-completion/bash_completion ] && . $(brew --prefix)/share/bash-completion/bash_completion
    [ -r $(brew --prefix)/etc/profile.d/bash_completion.sh ] && . $(brew --prefix)/etc/profile.d/bash_completion.sh
fi
# *NIX bash completion
if ! shopt -oq posix; then
    [ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
    [ -r /etc/bash_completion ] && . /etc/bash_completion
fi

# TMUX
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

PATH=$(find $PROFILE_LOCATION/functions -maxdepth 2 -type d | tr '\n' ':' | sed 's/:$//'):~/.bin:/usr/local/bin:/usr/local/sbin:$PATH

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

# direnv
# https://direnv.net/
hash direnv 2>/dev/null && eval "$( direnv hook bash )"

# fuzzy finder
# https://github.com/junegunn/fzf
hash fzf 2>/dev/null && eval "$( fzf --bash )"

# thefuck
# https://github.com/nvbn/thefuck
hash thefuck 2>/dev/null && eval $( thefuck --alias )

# Set PS1 with git if available
if [[ $( ps -p $( ps -p $$ -o ppid= ) -o args= ) == *"Hyper"* ]]; then
    export PS1="\u \$ "
else
    ps1_var="\[\e[1m\]\u"
    hash __git_ps1 2>/dev/null && ps1_var="$ps1_var\$(__git_ps1)"
    export PS1="$ps1_var \$ \[\e[0m\]"
    export PROMPT_COMMAND="$PROMPT_COMMAND"'; set-title $( dirs -0 )'
fi
