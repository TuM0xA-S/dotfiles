# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# cd without cd
# shopt -s autocd

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERMINAL=alacritty

. ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWSTASHSTATE=1
# ❱❱❱
# ❯❯❯
PS1='\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\[\033[01;32m\] ❯ \[\033[00m\]'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias g=git

export FZF_DEFAULT_COMMAND='fd --type f'

export EDITOR=emacsclient
export VISUAL=emacsclient

export LC_COLLATE="C"

reload() {
    source ~/.bashrc
    echo bashrc reloaded
}

fix() {
    stty sane
}

export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'

case $- in *i*)
    source /usr/share/bash-completion/bash_completion
;; esac

if [ -f ~/.local.sh ]; then
    source ~/.local.sh    
fi
