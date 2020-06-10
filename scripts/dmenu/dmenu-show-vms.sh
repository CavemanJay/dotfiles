#!/bin/bash
declare options=$(VBoxManage list vms | grep -o '\".*\"' | sed "s/\"//g")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Launch virtual machine: ')

vboxmanage startvm "$choice"
