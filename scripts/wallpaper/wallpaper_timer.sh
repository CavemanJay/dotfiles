#!/bin/bash

while true; do
    sleep $(tail -n 1 $HOME/scripts/wallpaper/interval) &
    $HOME/scripts/wallpaper/set_wallpaper.sh
    wait
done
