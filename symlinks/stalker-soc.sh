#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf $HOME/.local/share/Steam/steamapps/common/STALKER\ Shadow\ of\ Chernobyl\ RU/_appdata_/savedgames


if [[ -z $1 ]]; then 
    mkdir -p $HOME/.local/share/Steam/steamapps/common/STALKER\ Shadow\ of\ Chernobyl\ RU/_appdata_
    ln -s $MS_YD_SYNC/stalker-soc $HOME/.local/share/Steam/steamapps/common/STALKER\ Shadow\ of\ Chernobyl\ RU/_appdata_/savedgames
fi
