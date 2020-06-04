# dotfiles
Dotfiles for my linux systems

# Cloning to new system

## Configuration script

```
curl -Lks http://bit.do/jay-dotfiles | sh
```

## Manual
1. Set the alias for the dotfiles repo
```
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zsh/aliasrc
```

2. Add to .gitignore to prevent recursion problems
```
echo ".dotfiles" >> $HOME/.gitignore
```

3. Clone the repository
```
git clone --bare https://github.com/JayCuevas/dotfiles.git $HOME/.dotfiles
```

4. Update current shell scope to access the repo
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

5. Checkout the remote files
```
config checkout
```

   * If the initial checkout fails:
     ```
     mkdir -p $HOME/.config-backup && \
     config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
     xargs -I{} mv {} $HOME/.config-backup/{}
     ```
     
   * Rerun `config checkout`

6. Set the local repo to not show untracked files 
```
config config --local status.showUntrackedFiles no
```

7. Remove .gitignore (optional)
```
rm $HOME/.gitignore
```
