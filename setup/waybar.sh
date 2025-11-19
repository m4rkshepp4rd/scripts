#!/usr/bin/env bash

export SETUP_CFG="waybar"
CMD="waybar"
DEST="$HOME/.config/waybar"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST

killall waybar
waybar &
