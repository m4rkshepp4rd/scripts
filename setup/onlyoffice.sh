#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/onlyoffice"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi


if ! command -v "onlyoffice-desktopeditors" &> /dev/null; then
    paru -Sy onlyoffice-bin
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
   
mkdir -p $HOME/.config/onlyoffice
cp -f $config_fld/DesktopEditors.conf $HOME/.config/onlyoffice/DesktopEditors.conf
# cp -f $config_fld/onlyoffice-desktopeditors.json $HOME/.config/onlyoffice/desktopeditors/onlyoffice-desktopeditors.json
