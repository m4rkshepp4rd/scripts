#!/usr/bin/env bash

export SETUP_CFG="zsh"
CMD="zsh"
DEST="$HOME"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld

x-utils-cmd-install $CMD

if x-utils-has-flag "$*" -f --full; then
    chsh -s $(which zsh)
    paru -Sy --needed --noconfirm zsh-history-substring-search zsh-syntax-highlighting zsh-autosuggestions ttf-meslo-nerd-font-powerlevel10k

    p10k_path="$HOME/.powerlevel10k"
    if [[ -d $p10k_path ]]; then
        rm -rf $p10k_path
    fi
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $p10k_path
fi

x-utils-cfg-install $config_fld $DEST "$@"
set +e

echo "reload config"
