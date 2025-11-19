#!/usr/bin/env bash

if [[ " $* " == *" -h "* ]]; then
    echo "-m    Do no preserve monitors setup (does it by default)"
    exit 0
fi

export SETUP_CFG="hypr"
DEST="$HOME/.config/hypr"

if ! command -v hyprctl &> /dev/null; then
    echo "$(basename $2): hypr does not installed" >&2
    exit 1
fi

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld

preserve_monitors="0"
tmp_monitors="/tmp/.mymonitor-setup"
if [[ -f "$HOME/.config/hypr/monitors/current.conf" ]]; then
    cp -f "$HOME/.config/hypr/monitors/current.conf" $tmp_monitors
    preserve_monitors="1" 
fi

if x-utils-has-flag "$*" -m; then
    preserve_monitors="0"
fi

x-utils-cfg-install $config_fld $DEST "$@"


if [[ $preserve_monitors=="1" ]]; then
    mkdir -p "$HOME/.config/hypr/monitors"
    cp -f $tmp_monitors "$HOME/.config/hypr/monitors/current.conf"
fi

rm $tmp_monitors
set +e

hyprctl reload
sleep 2
clear
