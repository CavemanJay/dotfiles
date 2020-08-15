#!/bin/bash -x

safepaper() { 
    local WALLPAPER=$(ls -d $HOME/Pictures/wallpapers/* | shuf -n 1)
    feh --bg-fill $WALLPAPER
    echo "$WALLPAPER" > $HOME/scripts/wallpaper/current
}

unsafe() {
    FOLDER=$(cat $HOME/scripts/wallpaper/current)
    WALLPAPER=$(ls "$FOLDER" | grep -E "png|jpg" | shuf -n 1)
    WALLPAPER="$FOLDER/$WALLPAPER" 
    feh --bg-fill "$WALLPAPER"
}

SAFE=$(cat $HOME/scripts/wallpaper/safemode)

[[ SAFE -eq 1 ]] && safepaper || unsafe
