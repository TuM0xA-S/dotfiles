PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
source "$HOME/.bashrc"

# sleep because of conflict with gnome-settings-daemon
(sleep 1; setxkbmap -option caps:escape,grp:toggle -layout "us,ru" -variant ",") &
