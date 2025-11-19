#!/usr/bin/env bash

export SETUP_CFG="telegram"
CMD="Telegram"
DEST="$HOME/.local/share/TelegramDesktop/tdata"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-cmd-install $CMD telegram-desktop
x-utils-cfg-install $config_fld $DEST "$@"
set +e

