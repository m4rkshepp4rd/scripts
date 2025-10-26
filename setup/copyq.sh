#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/copyq"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi


if ! command -v "copyq" &> /dev/null; then
    paru -Sy copyq
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
   
mkdir -p $HOME/.config/copyq
cp -f $config_fld/copyq.conf $HOME/.config/copyq/copyq.conf
