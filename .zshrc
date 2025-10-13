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

if [[ -e .zsh-niri ]]; then
  source .zsh-niri
fi

# Setup default editor
if [[ -x nvim ]]; then
  echo "3"
  export EDITOR="nvim"

  gitEditor=$(git config --global --list | grep "core.editor")
  if [[ -z gitEditor ]]; then
    echo "1"
    git config --global core.editor nvim
  else
    echo "2"
  fi
fi


if [[ -f "$HOME/.zsh_private_env" ]]; then
  source "$HOME/.zsh_private_env"
fi

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
if [[ -d /usr/share/nvm ]]; then
  source /usr/share/nvm/nvm.sh
  source /usr/share/nvm/bash_completion
  # source /usr/share/nvm/install-nvm-exec
fi

alias y="yadm"

# NeoVim
alias vg="nvim --listen ~/.cache/nvim/godot.pipe ."
alias no="pnpm"
alias vconf="nvim ~/.config/nvim"
alias sv="sudo -e nvim"

export NVIM_USE_CC=false
export NVIM_USE_AVANTE=false

if [[ -x upower ]]; then
  alias batinfo="upower -i $(upower --enumerate | grep BAT)"
fi

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
alias v="nvim"
alias vc="zi && nvim ."
alias vc="zi && nvim ."
alias vr="sudo -e nvim"
alias vo="cd ~/Documents/Weissmall && v"

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

export PATH="$PATH:$HOME/fvm/default/bin"
alias pkginst="pacman -Qet"

eval "$(starship init zsh)"

export usersvc="/usr/lib/systemd/user/"

## ls to exa
alias ls="exa"


alias dbr="dart pub run build_runner build"
alias dbrc="dart pub run build_runner build --delete-conflicting-outputs"

alias pmm="pm2"

alias resource="source ~/.zshrc"
alias vrc="nvim ~/.zshrc"
alias vai="NVIM_USE_AVANTE=true proxychains -q nvim"
alias vco="NVIM_USE_COPILOT=true proxychains -q nvim"

# GO binaries
export PATH="$PATH:$HOME/go/bin"

# Git sync with submodules
alias gssync="git pull origin \$(git rev-parse --abbrev-ref HEAD) && git submodule update --init --recursive"

# nmcli aliases
#
# nmcli connection up
alias cou="nmcli connection up"
#
# nmcli connection down
alias cod="nmcli connection down"
