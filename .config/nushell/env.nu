use std/util "path add"

$env.XDG_CONFIG_HOME = $nu.home-path | path join  ".config"
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
$env.VIRTUAL_ENV_DISABLE_PROMPT = true

$env.config.buffer_editor = ["code","--wait"]
$env.config.edit_mode = 'vi'
$env.config.show_banner = false
$env.config.rm.always_trash = true

path add $"($nu.home-path)/.local/bin"

mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

zoxide init nushell | save -f ~/.zoxide.nu
