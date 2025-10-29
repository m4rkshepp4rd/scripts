#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

templates_fld="$HOME/.config/hypr/monitors"
cur_conf="$templates_fld/current.conf"

if [[ " $* " == *" -r "* ]]; then
    rm "$cur_conf" &> /dev/null
    touch "$cur_conf"
    exit 0
fi

if [[ ! -d $templates_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi

if [[ -z $1 ]]; then
    echo "($(basename $0))" "Enter preset name"
    exit 1
fi

if [[ ! -f "$templates_fld/$1.conf" ]]; then
    echo "($(basename $0))" "Preset $1 not found"
fi

rm "$cur_conf" &> /dev/null
ln -s "$templates_fld/$1.conf" "$cur_conf"
