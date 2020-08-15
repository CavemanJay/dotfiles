#!/bin/bash -x

LOCKFILE=~/.timer.lock

[[ -f "$LOCKFILE" ]] && echo "Lock file already exists... exiting" && exit -1

touch $LOCKFILE && trap "rm -f $LOCKFILE" EXIT 

while true; do
    sleep $(tail -n 1 $HOME/scripts/wallpaper/interval) &
    $HOME/scripts/wallpaper/set_wallpaper.sh
    wait
done
