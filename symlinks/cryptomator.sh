#!/usr/bin/env bash

if [[ -z $MS_DOCS ]]; then
    echo "($(basename $0))" "Env var MS_DOCS not defined"
    exit 1
fi

rm -rf $HOME/Documents/_42
rm -rf $HOME/Documents/_photo
rm -rf $HOME/Documents/_docs


if [[ -z $1 ]]; then  
    ln -s $HOME/.local/share/Cryptomator/mnt/_42 $HOME/Documents/_42
    ln -s $HOME/.local/share/Cryptomator/mnt/_photo $HOME/Documents/_photo
    ln -s $MS_DOCS $HOME/Documents/_docs
fi
