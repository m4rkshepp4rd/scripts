#!/usr/bin/env bash
export SETUP_CFG="btop"
CMD="btop"
DEST="$HOME/.config/btop"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST "$@"
mkdir -p "$DEST/themes"
ls -s "$DEST/themes/current.theme" "$HOME/.config/omarchy/current/theme/btop.theme" &> /dev/null
set +e
