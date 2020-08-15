#!/bin/sh -x
ping -W 2 -c 2 jay-alien 2>&1 1>/dev/null || (echo "Computer unreachable" && exit) && \
rsync -Pavzz "$@" ~/Sync/Backgrounds/ /mnt/alien 
