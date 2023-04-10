eval $(ssh-agent >/dev/null)
ssh-add 2>/dev/null
source "$HOME/.bashrc"
# [ "$(tty)" = "/dev/tty1" ] && startx
