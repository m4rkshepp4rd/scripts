#!/usr/bin/env bash

if [[ -z $MS_DOCS ]]; then
    echo "($(basename $0))" "Env var MS_DOCS not defined"
    exit 1
fi

rm -rf $HOME/.local/share/DBeaverData

if [[ -z $1 ]]; then 
    ln -s $MS_DOCS/programdata/dbeaver $HOME/.local/share/DBeaverData
fi
