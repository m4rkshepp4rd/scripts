#!/usr/bin/env bash

if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi

rm -rf $HOME/.x

if [[ -z $1 ]]; then 
    ln -s $MS_SCR $HOME/.x
fi
