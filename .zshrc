# Dependancies You Need for this Config
# zsh-syntax-highlighting - syntax highlighting for ZSH in standard repos
# autojump - jump to directories with j or jc for child or jo to open in file manager
# zsh-autosuggestions - Suggestions based on your history

# Initial Setup
# mkdir -p "$HOME/.zsh"
# git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
# Setup Alias in $HOME/.zsh/aliasrc

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "


# Pure Prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand_alias _complete _ignored
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump
_comp_options+=(globdots)               # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.zsh/aliasrc" ] && source "$HOME/.zsh/aliasrc"

[[ -s /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

# Load ; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null # Enable autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # Enable syntax highlighting
source /usr/share/autojump/autojump.zsh 2>/dev/null # Enable autojump
source /usr/share/doc/pkgfile/command-not-found.zsh # Enable command not found

source $HOME/scripts/zsh/extract.plugin.zsh

# Rust
source $HOME/.cargo/env

#[[ -s /home/jay/.autojump/etc/profile.d/autojump.sh ]] && source /home/jay/.autojump/etc/profile.d/autojump.sh

export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"
export PATH="$PATH:$HOME/.vim/bundle/vim-live-latex-preview/bin"
export PATH="$PATH:$HOME/.nvm/versions/node/v14.4.0/bin/"
compdef vman="man"

eval $(thefuck --alias)

neofetch

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/jaydlc/.nvm/versions/node/v14.4.0/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/jaydlc/.nvm/versions/node/v14.4.0/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh
