#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/env"

if [[ ! -z $1 && -d $1 ]]; then
    config_fld=$1
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
    
cp -f $config_fld/.sharenv $HOME/.sharenv

cp -f $config_fld/.jira-token $HOME/.config/.jira-token
cp -f $config_fld/.confluence-token $HOME/.config/.confluence-token
cp -f $config_fld/.gpg-pass $HOME/.config/.gpg-pass
cp -f $config_fld/.myhardware.yml $HOME/.config/.myhardware.yml
cp -f $config_fld/.work-bookmarks $HOME/.config/.work-bookmarks
chmod 600 $HOME/.config/.jira-token
chmod 600 $HOME/.config/.confluence-token
chmod 600 $HOME/.config/.gpg-pass
chmod 600 $HOME/.config/.myhardware.yml

echo "reload config"