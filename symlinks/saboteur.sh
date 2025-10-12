#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf $HOME/.local/share/Steam/steamapps/compatdata/24880/pfx/drive_c/users/steamuser/Documents/My\ Games/The\ Saboteur™


if [[ -z $1 ]]; then 
    mkdir -p $HOME/.local/share/Steam/steamapps/compatdata/24880/pfx/drive_c/users/steamuser/Documents/My\ Games
    ln -s $MS_YD_SYNC/the-saboteur $HOME/.local/share/Steam/steamapps/compatdata/24880/pfx/drive_c/users/steamuser/Documents/My\ Games/The\ Saboteur™
fi
