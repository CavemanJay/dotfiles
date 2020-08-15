#!/bin/bash -x

root="$HOME/Pictures/wallpapers"
WALLPAPER=$(ls $root | shuf -n 1)
feh --bg-fill "$root/$WALLPAPER"
echo "$WALLPAPER" > $HOME/scripts/wallpaper/current
echo 1 > $HOME/scripts/wallpaper/safemode
