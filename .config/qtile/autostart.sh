#!/bin/bash
udiskie -A -t &
picom &
clipmenud &
nm-applet &
# /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 & 
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &
