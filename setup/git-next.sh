#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

git_cfg="$MS_CFG/git"

if [[ ! -d $git_cfg ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi

n=$(ls -lA "$git_cfg" | grep -n "$(cat .git-profile)" | awk -F: '{print $1}')
nxt=$(ls -lA "$git_cfg" | head -n $(($n+1)) | tail -n 1 | awk '{print $NF}')

[ $nxt != $(cat .git-profile) ] && x-setup-git $nxt && exit 0

first=$(ls -lA "$git_cfg" | grep -v total | head -n 1 | awk '{print $NF}')
x-setup-git $first
