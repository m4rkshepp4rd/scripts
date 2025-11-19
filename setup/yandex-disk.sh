#!/usr/bin/env bash

export SETUP_CFG="yandex-disk"
CMD="yandex-disk"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-cmd-install $CMD
set +e

rm -rf $HOME/.config/yandex-disk

yandex-disk setup
yandex-disk stop
echo 'exclude-dirs="_42,_photo,articles,cv,edu,games,books,music,pictures,programs,videos"' >> $HOME/.config/yandex-disk/config.cfg
yandex-disk start
