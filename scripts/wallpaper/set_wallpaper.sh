#!/bin/bash

FOLDER=$(cat /home/jaydlc/scripts/wallpaper/current)
WALLPAPER=$(ls "$FOLDER" | grep .jpg | shuf -n 1)
WALLPAPER="$FOLDER/$WALLPAPER" 
feh --bg-fill "$WALLPAPER"
