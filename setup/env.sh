#!/usr/bin/env bash

export SETUP_CFG="env"
DEST="$HOME/.config"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
set +e

x-utils-cfg-install $config_fld $DEST

chmod 600 $HOME/.config/.jira-token
chmod 600 $HOME/.config/.confluence-token
chmod 600 $HOME/.config/.gpg-pass
chmod 600 $HOME/.config/.myhardware.yml

echo "reload config"
