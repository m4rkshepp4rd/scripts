#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/pop-shell"
pop_shell_fld="$HOME/.config/pop-shell"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi

mkdir -p $pop_shell_fld
cp -f $config_fld/config.json $pop_shell_fld/config.json
