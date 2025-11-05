#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

git_crypto="$MS_CFG/git/$1"


if ! command -v "git" &> /dev/null; then
    paru -Sy git
fi

if [[ ! -d $git_crypto ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
  

cp -rf $git_crypto/. $HOME
chmod 600 $HOME/.git-credentials
