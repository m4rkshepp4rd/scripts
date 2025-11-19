#!/usr/bin/env bash

export SETUP_CFG="pop-shell"
DEST="$HOME/.config/pop-shell"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cfg-install $config_fld $DEST
