# You may need to comment out the next line to disable access control.
#xhost +SI:localuser:$USER

# Set themes, etc.
gnome-settings-daemon &

# Set fallback cursor.
xsetroot -cursor_name left_ptr

# Set keyboard repeat rate.
xset r rate 200 60

# If Emacs is started in server mode, `emacsclient` is a convenient way to
# edit files in place (used by e.g. `git commit`).
export VISUAL=emacsclient
export EDITOR="$VISUAL"

exec remove-emacs-lock-if-exist.sh &&

# Finally launch emacs.
exec dbus-launch --exit-with-session ~/emacs27/bin/emacs --debug-init &&

#if [ -s ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
#fi

xmodmap .Xmodmap_bkp

#setxkbmap -option shift:both_capslock

#if [ -s ~/bin/set-shifts-to-capslock.sh ]; then
#    sh ~/bin/set-shifts-to-capslock.sh
#fi

#if [ -s ~/.profile ]; then
#    source ~/.profile
#fi

# exec ~/bin/set-shifts-to-capslock.sh &&
# exec ~/bin/set-xmodmap.sh &&

# exec --no-startup-id ~/bin/connect-to-wifi.sh off &&

# sleep 10.0 &&
# exec ~/bin/set-dual-monitor.sh



