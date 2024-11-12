# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  # source /usr/share/zsh/manjaro-zsh-prompt
fi

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

alias y="yadm"
alias vg="nvim --listen ~/.cache/nvim/godot.pipe ."
alias no="pnpm"
alias vconf="nvim ~/.config/nvim"
alias batinfo="upower -i $(upower --enumerate | grep BAT)"
alias sv="sudo -e nvim"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# RofiThemes
export PATH="$PATH:$HOME/.config/rofi/scripts"

# DCM
export PATH="$PATH:/opt/dcm"

if [[ $TERM = "foot-extra" ]]; then
  alias ssh='TERM=linux ssh'
fi

if [[ $TERM = "kitty" ]]; then
  alias ssh='TERM=linux ssh'
fi

eval "$(zoxide init zsh)"
alias vc="zi && nvim ."

# Flutter
# export PATH="$PATH:/opt/flutter/bin"
# export FLUTTER_GIT_URL="https://github.com/flutter/flutter.git"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/weissmall/.dart-cli-completion/zsh-config.zsh ]] && . /home/weissmall/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

## [FVM]
##
# alias flutter="fvm flutter"
# alias dart="fvm dart"

export PATH="$PATH:/home/weissmall/fvm/default/bin"
alias pkginst="pacman -Qet"

eval "$(starship init zsh)"

export usersvc="/usr/lib/systemd/user/"
