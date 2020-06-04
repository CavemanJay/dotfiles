# dotfiles
Dotfiles for my linux systems

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
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

4. Checkout the remote files
```
config checkout
```

   * If the initial checkout fails delete or backup the existing files and then rerun `config checkout`

6. Set the local repo to not show untracked files 
```
config config --local status.showUntrackedFiles no
```

7. Update current shell
```
source $HOME/.zshrc
```

8. Remove .gitignore (optional)
```
rm $HOME/.gitignore
```
