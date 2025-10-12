#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

git_crypto="$MS_CFG/git/$1"


bin_path="$(which git)"
if [[ -z $bin_path ]]; then
    paru -Sy git
fi

if [[ ! -d $git_crypto ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
  
cp -f $git_crypto/.gitconfig $HOME/.gitconfig
cp -f $git_crypto/.git-credentials $HOME/.git-credentials
chmod 600 $HOME/.git-credentials
