#!/bin/bash
declare options=("aliases
awesome
bash
qtile
qutebrowser
vim
xresources
zsh
quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config file: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	awesome)
		choice="$HOME/.config/awesome/"
	;;
	aliases)
		choice="$HOME/.zsh/aliasrc"
	;;
	bash)
		choice="$HOME/.bashrc"
	;;
	picom)
		choice="$HOME/.config/picom/picom.conf"
	;;
	qtile)
		choice="$HOME/.config/qtile/"
	;;
	qutebrowser)
		choice="$HOME/.config/qutebrowser/"
	;;
	vifm)
		choice="$HOME/.config/vifm/vifmrc"
	;;
	vim)
		choice="$HOME/.vimrc"
	;;
	xresources)
		choice="$HOME/.Xresources"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	*)
		exit 1
	;;
esac
code "$choice"
