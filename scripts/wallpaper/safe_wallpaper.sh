#!/bin/bash -x

root="$HOME/Pictures/wallpapers"
feh --randomize --bg-fill $root

echo 1 > $HOME/scripts/wallpaper/safemode
