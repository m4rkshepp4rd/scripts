#!/usr/bin/env bash
export SETUP_CFG="rofi"
CMD="rofi"
DEST="$HOME/.config/rofi"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST "$@"
set +e
