#
# ~/.bash_profile
#

if [ $(tty) == "/dev/tty1" ]; then
    exec uwsm start niri.desktop
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
