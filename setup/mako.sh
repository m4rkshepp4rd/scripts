#!/usr/bin/env bash
export SETUP_CFG="mako"
CMD="mako"
DEST="$HOME/.config/mako"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST "$@"
set +e

makoctl reload
