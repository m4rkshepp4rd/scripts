#!/usr/bin/env bash

rm $HOME/.config/yandex-disk/config.cfg


if ! command -v "yandex-disk" &> /dev/null; then
    paru -Sy yandex-disk
fi

yandex-disk setup
yandex-disk stop
echo 'exclude-dirs="_42,_photo,articles,cv,edu,games,books,music,pictures,programs,videos"' >> $HOME/.config/yandex-disk/config.cfg
yandex-disk start
