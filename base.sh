#!/usr/bin/env bash


if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi

if [[ ! -d $MS_SCR ]]; then
    echo "($(basename $0))" "Scripts folder not found"
    exit 1
fi

bash $MS_SCR/setup/env.sh

bash $MS_SCR/setup/zsh.sh
bash $MS_SCR/setup/bash.sh

bash $MS_SCR/chmodx.sh
bash $MS_SCR/bin-update.sh

if [[ $XDG_CURRENT_DESKTOP == "GNOME"]]; then
    bash $MS_SCR/gnome/settings.sh  
    bash $MS_SCR/gnome/shortcuts.sh 
fi

bash $MS_SCR/setup/base-symlinks.sh
bash $MS_SCR/symlinks/docs.sh

bash $MS_SCR/setup/pyvenv.sh x

bash $MS_SCR/setup/apps.sh
bash $MS_SCR/setup/python-packages.sh

echo "reload config"
