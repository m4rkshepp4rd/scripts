#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/hyprland"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi

preserve_monitors="0"
tmp_monitors="/tmp/.mymonitor-setup"
if [[ -f "$HOME/.config/hypr/monitors/current.conf" ]]; then
    cp -f "$HOME/.config/hypr/monitors/current.conf" $tmp_monitors
    preserve_monitors="1" 
fi

if [[ " $* " == *" -m "* ]]; then
    preserve_monitors="0"
fi

rm -rf $HOME/.config/hypr
mkdir -p $HOME/.config/hypr
cp -r $config_fld/* $HOME/.config/hypr

if [[ $preserve_monitors=="1" ]]; then
    cp -f $tmp_monitors "$HOME/.config/hypr/monitors/current.conf"
fi

rm $tmp_monitors

hyprctl reload
sleep 2
clear
