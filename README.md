# dotfiles

Dotfiles for my linux systems

## Quick Setup

```
curl -s https://gist.githubusercontent.com/JayCuevas/c78a7810606d4936f120be2b6d79f480/raw/45c8c0c8e9790b85599c936e08a7d84d0877ef3a/arch_setup.sh | bash
```

## Cloning to new system

1. Add to .gitignore to prevent recursion problems

```
echo ".dotfiles" >> $HOME/.gitignore
```

2. Clone the repository

```
git clone --bare https://github.com/JayCuevas/dotfiles.git $HOME/.dotfiles
```

3. Update current shell scope to access the repo

```
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

4. Checkout the remote files

```
cfg checkout
```

- If the initial checkout fails delete or backup the existing files and then rerun `config checkout`

5. Get the pure zsh theme

```
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
```

6. Set the local repo to not show untracked files

```
cfg config --local status.showUntrackedFiles no
```

7. Update current shell

```
source $HOME/.zshrc
```

8. Remove .gitignore (optional)

```
rm $HOME/.gitignore
```

9. Change default shell to zsh

10. Installing Packages

- Install yay

```bash

mkdir ~/repos
cd ~/repos
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
```

- Install default packages

```bash
yay -S zsh zsh-autosuggestions zsh-syntax-highlighting alsa-utils libpulse python-iwlib python-psutil python-setproctitle qtile neofetch thefuck pkgfile mlocate picom alacritty bashtop cheat clipmenu polkit-gnome udiskie xfce4-power-manager dunst i3lock lxappearance networkmanager network-manager-applet pulseaudio ranger tldr ueberzug j4-dmenu-desktop-git tmux
```
