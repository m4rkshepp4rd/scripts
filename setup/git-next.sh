#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_CFG
git_cfg="$MS_CFG/git"
x-utils-check dir "$git_cfg"
set +e

n=$(ls -lA "$git_cfg" | grep -n "$(cat .git-profile)" | awk -F: '{print $1}')
nxt=$(ls -lA "$git_cfg" | head -n $(($n+1)) | tail -n 1 | awk '{print $NF}')

[ $nxt != $(cat .git-profile) ] && x-setup-git $nxt && exit 0

first=$(ls -lA "$git_cfg" | grep -v total | head -n 1 | awk '{print $NF}')
x-setup-git -p $first
