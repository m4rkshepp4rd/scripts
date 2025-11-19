#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_CFG_BACKUPS
x-utils-check dir $0 "$MS_CFG_BACKUPS"
set +e

config_fld="$MS_CFG_BACKUPS/$(hostname)"

rmkdir() {
    rm -rf "$config_fld/$1"
    mkdir -p "$config_fld/$1"
}

backup_cfg() {
    for fld in "$@"; do
        rmkdir $fld
        cp -r $HOME/.config/$fld/. "$config_fld/$fld"
        touch "$config_fld/$fld/.foolproof"
    done
}

rmkdir env
cp -f $HOME/.sharenv "$config_fld/env/.sharenv"
cp -f $HOME/.config/.myhardware.yml "$config_fld/env/.myhardware.yml"
touch "$config_fld/env/.foolproof"

rmkdir bash
cp -f $HOME/.bashrc "$config_fld/bash/.bashrc"
touch "$config_fld/bash/.foolproof"

rmkdir zsh
cp -f $HOME/.zshrc "$config_fld/zsh/.zshrc"
cp -f $HOME/.zshenv "$config_fld/zsh/.zshenv"
cp -f $HOME/.p10k.zsh "$config_fld/zsh/.p10k.zsh"
touch "$config_fld/zsh/.foolproof"

rmkdir telegram
cp -f $HOME/.local/share/TelegramDesktop/tdata/shortcuts-custom.json "$config_fld/telegram/shortcuts-custom.json"
touch "$config_fld/telegram/.foolproof"

rmkdir vscode
code-insiders --list-extensions > "$config_fld/vscode/extensions.txt"
cp -f $HOME/.config/Code\ -\ Insiders/User/settings.json "$config_fld/vscode/settings.json"
touch "$config_fld/vscode/.foolproof"

rmkdir cron
crontab -l > "$config_fld/cron/crontab"
touch "$config_fld/cron/.foolproof"

rmkdir copyq
cp -f $HOME/.config/copyq/copyq.conf "$config_fld/copyq/copyq.conf"
touch "$config_fld/copyq/.foolproof"

backup_cfg tmux hypr waybar onlyoffice yandex-disk flameshot pop-shell alacritty swayosd

echo "$(basename $0): configs saved"
