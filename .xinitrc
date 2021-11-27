export QT_AUTO_SCREEN_SCALE_FACTOR=1
# QT_SCALE_FACTOR=2
export LIBGL_DRI3_DISABLE=1

setxkbmap -option caps:escape,grp:toggle,terminate:ctrl_alt_bksp -layout "us,ru" -variant ","
# greenclip daemon &

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

exec dbus-launch spectrwm

