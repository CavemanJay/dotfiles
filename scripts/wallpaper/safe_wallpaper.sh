#!/bin/zsh

root='/usr/share/backgrounds'
FOLDER=$(ls $root | shuf -n 1)
WALLPAPER=$(ls "$root/$FOLDER" | shuf -n 1)
WALLPAPER=$(locate $WALLPAPER | grep -v ".cache" | head -n 1)
feh --bg-fill "$WALLPAPER"
echo $(dirname "$WALLPAPER") > $HOME/scripts/wallpaper/current
