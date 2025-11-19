#!/usr/bin/env bash

export SETUP_CFG="tmux"
CMD="tmux"
DEST="$HOME/.config/tmux"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST

tmux source-file $HOME/.config/tmux/tmux.conf
