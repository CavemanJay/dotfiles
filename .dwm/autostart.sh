#!/bin/bash
udiskie -A -t &
picom --log-file $HOME/.picom.log &
clipmenud &
#pa-applet --disable-notifications &
nm-applet &
$HOME/scripts/wallpaper/wallpaper_timer.sh &
xfce4-power-manager &
# /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 & 
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

dwmblocks &

#while xsetroot -name "`date +"%m/%d/%Y %I:%M %p"`"
#do
#    sleep 60
#done &

