#!/usr/bin/env bash

export SETUP_CFG="ssh"
DEST="$HOME/.ssh"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-check file $0 "$config_fld/config"
set +e

if [[ ! -d "$DEST" ]]; then
    mkdir "$DEST"
fi

cp -f "$config_fld/config" "$DEST"

x-utils-chmod700 "$DEST"

