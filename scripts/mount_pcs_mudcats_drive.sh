#!/bin/sh -x

sudo mount.cifs '//192.168.16.130/Mudcats$' /mnt/mudcats --verbose -o credentials=/etc/pcs-credentials,uid=1000,gid=1000,dir_mode=0755,file_mode=0755
