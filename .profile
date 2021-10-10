PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
eval $(ssh-agent)
ssh-add
source "$HOME/.bashrc"

[ "$(tty)" = "/dev/tty1" ] && startx
