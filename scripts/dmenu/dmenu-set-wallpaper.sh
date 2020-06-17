#!/bin/bash
declare options=$(ls $HOME/Sync/Backgrounds)

choice=$(echo -e "${options[@]}" | dmenu -i -c -l 20 -p 'Choose wallpaper folder: ')

echo "$HOME/Sync/Backgrounds/$choice" > $HOME/scripts/wallpaper/current

source $HOME/scripts/wallpaper/set_wallpaper.sh
