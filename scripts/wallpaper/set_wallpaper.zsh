#!/bin/zsh

FOLDER=$(cat /home/jaydlc/scripts/wallpaper/current)
WALLPAPER=$(ls "$FOLDER" | shuf -n 1)
WALLPAPER="$FOLDER/$WALLPAPER" 
feh --bg-fill "$WALLPAPER"
