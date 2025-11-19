#!/usr/bin/env bash

export SETUP_CFG="bash"
CMD="bash"
DEST="$HOME"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST

echo "reload config"
