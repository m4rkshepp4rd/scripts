#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/tmux"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi


bin_path="$(which tmux)"
if [[ -z $bin_path ]]; then
    paru -Sy tmux
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
   
mkdir -p $HOME/.config/tmux
cp -f $config_fld/tmux.conf $HOME/.config/tmux/tmux.conf

tmux source-file $HOME/.config/tmux/tmux.conf

