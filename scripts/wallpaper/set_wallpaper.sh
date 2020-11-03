#!/bin/bash -x

is_safemode(){
    safe=$(cat $HOME/scripts/wallpaper/safemode)
    return $([[ $safe -eq 1 ]])
}

safepaper() { 
    local WALLPAPER=$(ls -d $HOME/Pictures/wallpapers/* | shuf -n 1)
    feh --bg-fill $WALLPAPER
    echo "$WALLPAPER" > $HOME/scripts/wallpaper/current
}

get_current_feh(){
    echo $(grep -oE "'.*'" ~/.fehbg | sed "s/'//g")
}

get_current(){
    current=$(cat ~/scripts/wallpaper/current)
    current=$(basename "$current")
    echo $current
}

unsafe() {
    folder=$(cat ~/scripts/wallpaper/current)
#   WALLPAPER=$(ls "$FOLDER" | grep -E "png|jpg" | shuf -n 1)
#   WALLPAPER="$FOLDER/$WALLPAPER" 
    feh --randomize --bg-fill "$folder"
}


is_safemode && safepaper || unsafe
is_safemode && basename `get_current_feh` > ~/scripts/wallpaper/current


