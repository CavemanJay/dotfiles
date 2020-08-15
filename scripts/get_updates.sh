#!/bin/bash
sudo pacman -Syy
pacman -Qu 1>/dev/null && notify-send -i "/var/lib/snapd/snap/gtk-common-themes/1506/share/icons/elementary-xfce/status/48/software-update-available.png" "$(pacman -Qu | wc -l) updates available" && sudo pacman -Syyuw
