#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf $HOME/.local/share/Steam/steamapps/compatdata/7670/pfx/drive_c/users/steamuser/Documents/Bioshock/SaveGames

if [[ -z $1 ]]; then
    mkdir -p $HOME/.local/share/Steam/steamapps/compatdata/7670/pfx/drive_c/users/steamuser/Documents/Bioshock
    ln -s $MS_YD_SYNC/bioshock $HOME/.local/share/Steam/steamapps/compatdata/7670/pfx/drive_c/users/steamuser/Documents/Bioshock/SaveGames
fi