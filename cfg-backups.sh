#!/usr/bin/env bash

if [[ -z $MS_CFG_BACKUPS ]]; then
    echo "($(basename $0))" "Env var MS_CFG_BACKUPS not defined"
    exit 1
fi

if [[ ! -d "$MS_CFG_BACKUPS" ]]; then
    echo "($(basename $0))" "Backups folder not found"
    exit 1
fi

config_fld="$MS_CFG_BACKUPS/$(hostname)"


mkdir -p "$config_fld/bash"
cp -f $HOME/.bashrc "${config_fld}/bash/.bashrc"


mkdir -p "$config_fld/zsh"
cp -f $HOME/.zshrc "${config_fld}/zsh/.zshrc"
cp -f $HOME/.zshenv "${config_fld}/zsh/.zshenv"
cp -f $HOME/.p10k.zsh "${config_fld}/zsh/.p10k.zsh"


mkdir -p "$config_fld/env"
cp -f $HOME/.sharenv "${config_fld}/env/.sharenv"
cp -f $HOME/.config/.myhardware.yml "${config_fld}/env/.myhardware.yml"


mkdir -p "$config_fld/flameshot"
cp -f $HOME/.config/flameshot/flameshot.ini "${config_fld}/flameshot/flameshot.ini"


mkdir -p "$config_fld/copyq"
cp -f $HOME/.config/copyq/copyq.conf "${config_fld}/copyq/copyq.conf"

mkdir -p "$config_fld/tmux"
cp -f $HOME/.config/tmux/tmux.conf "${config_fld}/tmux/tmux.conf"


mkdir -p "$config_fld/onlyoffice"
cp -f $HOME/.config/onlyoffice/DesktopEditors.conf "${config_fld}/onlyoffice/DesktopEditors.conf"


mkdir -p "$config_fld/pop-shell"
cp -f $HOME/.config/pop-shell/config.json "${config_fld}/pop-shell/config.json"


mkdir -p "$config_fld/yandex-disk"
cp -f $HOME/.config/yandex-disk/config.cfg "${config_fld}/yandex-disk/config.cfg"


mkdir -p "$config_fld/telegram"
cp -f $HOME/.local/share/TelegramDesktop/tdata/shortcuts-custom.json "${config_fld}/telegram/shortcuts-custom.json"


mkdir -p "$config_fld/vscode"
code-insiders --list-extensions > "${config_fld}/vscode/extensions.txt"
cp -f $HOME/.config/Code\ -\ Insiders/User/settings.json "${config_fld}/vscode/settings.json"


mkdir -p "$config_fld/cron"
crontab -l > "${config_fld}/cron/crontab"


echo "($(basename $0))" "Configs saved"

