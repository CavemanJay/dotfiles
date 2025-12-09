source $"($nu.cache-dir)/carapace.nu"
source ~/.zoxide.nu
source "direnv.nu"

alias vim = nvim
alias lj = lazyjj


mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

