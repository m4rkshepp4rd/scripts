#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf $HOME/.config/onlyoffice

if [[ -z $1 ]]; then 
    ln -s $MS_YD_SYNC/onlyoffice $HOME/.config/onlyoffice
fi
