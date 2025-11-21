#!/usr/bin/env bash

export SETUP_CFG="yandex-disk"
CMD="yandex-disk"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-check file $0 "$config_fld/default"
x-utils-cmd-install $CMD
set +e

rm -rf $HOME/.config/yandex-disk

yandex-disk setup
yandex-disk stop
cat "$config_fld/default" >> $HOME/.config/yandex-disk/config.cfg
nano "$HOME/.config/yandex-disk/config.cfg"
yandex-disk start
