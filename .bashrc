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

PS1='[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]$(__git_ps1)\n\[\033[01;34m\]>\[\033[00m\] '

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .[!.]*'

# use kak as pager
alias less="kak -ro"
alias h="cd .."
alias cdgr='cd $(git root)'
alias g=git
# kcr alias
alias ke="kcr edit"
alias ka="kcr attach"
alias kc="kcr create"
alias kl="kcr list"
alias kn="kcr env"
alias kk="kcr kill"
alias k="kak"
alias kfm="kak -e 'files-new-browser'"

alias usql="PAGER=kak usql"
alias grpcurl="grpcurl -plaintext"

dy() {
    pwd > $HOME/.wd
}
export -f dy

dp() {
    cd $(cat $HOME/.wd)
}
export -f dp

export FZF_DEFAULT_OPTS="--reverse --bind=tab:down,btab:up --cycle"

fcd() {
    local res="$(fd -t d . $* | shell_fzf)"
    [ -n "$res" ] && cd $res
}

kzf() {
    local res="$(shell_fzf --multi)"
    [ -n "$res" ] && ke $res
}

export FZF_DEFAULT_COMMAND='fd --type f'

alias vault="VAULT_ADDR=https://vault.s.o3.ru:8200 vault"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias size='du -bsh'

alias qtrans='trans -show-dictionary n -show-languages n -show-original n -show-prompt-message n -show-translation n'

man () { kak -e "man $1"; }

export -f man

export MANPAGER=manpager.sh

add_path() {
    new_path="$1"
    if [ -d "$new_path" ] && ! echo "$PATH" | rg "$new_path" > /dev/null ; then
        PATH="$new_path:$PATH"
    fi
}

export EDITOR=kak
export VISUAL=kak
# set -o vi
export DELVE_EDITOR="kcr-edit"

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

export -f n
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'
export LC_COLLATE="C"

show_containers() {
    kubectl get pods $1 -o jsonpath='{.spec.containers[*].name}'
    echo
}

reload() {
    source ~/.bashrc
    echo bashrc reloaded
}

shell_fzf() {
    fzf --height 40% "$@"
}

fix() {
    stty sane
}

source /home/tum0xa/.config/broot/launcher/bash/br
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'

case $- in *i*)
    copyline() { printf %s "$READLINE_LINE"|xclip -se c; }
    bind -x '"\C-x\C-y":copyline'

    source $HOME/.fzf-bash-completion.sh
    PROMPT_COMMAND="echo -ne \"\033]0;$(basename $0) "'$(smart_path.sh)'"\007\"; stty $(stty -g)"
    bind -x '"\t": fzf_bash_completion'

    bind -x '"\e[15~": reload'
    source <(kubectl completion bash)
    source /usr/share/bash-completion/bash_completion
;; esac

dotfiles() {
    local res="$(cat ~/.dotfiles | shell_fzf)"
    [ -n "$res" ] && k $res
}
alias dot=dotfiles

export GOLANG_PROTOBUF_REGISTRATION_CONFLICT=warn
export PGUSER=postgres
