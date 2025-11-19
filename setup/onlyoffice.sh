#!/usr/bin/env bash

export SETUP_CFG="onlyoffice"
CMD="onlyoffice-desktopeditor"
DEST="$HOME/.config/onlyoffice"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cmd-install $CMD onlyoffice-bin
x-utils-cfg-install $config_fld $DEST
