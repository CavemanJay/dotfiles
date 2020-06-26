#!/bin/bash
udiskie -A -t &
picom &
clipmenud &
pa-applet &
 nm-applet &
# $HOME/scripts/wallpaper/wallpaper_timer.sh &
xfce4-power-manager &
# /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 & 
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &
