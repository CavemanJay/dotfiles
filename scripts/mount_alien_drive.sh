#!/bin/sh -x

sudo mount.cifs '//JAY-ALIEN/Users/cueva/Pictures/backgrounds' /mnt/alien --verbose -o credentials=/root/Documents/alien-credentials,uid=1000,gid=1000,dir_mode=0755,file_mode=0755
