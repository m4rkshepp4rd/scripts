#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/zsh"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi

bin_path="$(which zsh)"
if [[ -z $bin_path ]]; then
    paru -Sy zsh
    chsh -s $(which zsh)
fi

if [[ " $* " == *" -f "* ]]; then
    paru -Sy --needed --noconfirm zsh-history-substring-search zsh-syntax-highlighting zsh-autosuggestions ttf-meslo-nerd-font-powerlevel10k

    p10k_path=$HOME/.powerlevel10k
    if [[ -d $p10k_path ]]; then
        rm -rf $p10k_path
    fi
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $p10k_path
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
    
cp -f $config_fld/.zshrc $HOME/.zshrc
cp -f $config_fld/.zshenv $HOME/.zshenv
cp -f $config_fld/.p10k.zsh $HOME/.p10k.zsh

echo "reload config"