#!/usr/bin/env bash

export SETUP_CFG="git"
CMD="git"
DEST="$HOME"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST

chmod 600 $HOME/.git-credentials
