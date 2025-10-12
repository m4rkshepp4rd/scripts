#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm $HOME/.local/share/Steam/steamapps/compatdata/257750/pfx/drive_c/users/steamuser/AppData/Roaming/Bloody\ Trapland


if [[ -z $1 ]]; then
    mkdir -p $HOME/.local/share/Steam/steamapps/compatdata/257750/pfx/drive_c/users/steamuser/AppData/Roaming
    ln -s $MS_YD_SYNC/bloody-trapland $HOME/.local/share/Steam/steamapps/compatdata/257750/pfx/drive_c/users/steamuser/AppData/Roaming/Bloody\ Trapland
fi
