#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf $HOME/.local/share/Steam/steamapps/common/Half-Life/czero/Save

if [[ -z $1 ]]; then 
    mkdir -p $HOME/.local/share/Steam/steamapps/common/Half-Life/czero
    ln -s $MS_YD_SYNC/cszero $HOME/.local/share/Steam/steamapps/common/Half-Life/czero/Save
fi
