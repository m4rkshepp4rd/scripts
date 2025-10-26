#!/usr/bin/env bash

if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi

rm -rf $HOME/.x
ln -s $MS_SCR $HOME/.x

if [[ " $* " == *" -l "* ]]; then
    if [[ -z $MS_DOCS ]]; then
        echo "($(basename $0))" "Env var MS_DOCS not defined"
        exit 1
    fi
    rm "$MS_SCR/_configs"
    ln -s "$MS_DOCS/configs" "$MS_SCR/_configs"
    rm "$MS_SCR/_cfg-backups"
    ln -s "$MS_DOCS/cfg-backups" "$MS_SCR/_cfg-backups"
    rm "$MS_SCR/todo.md"
    ln -s "$MS_DOCS/todo.md" "$MS_SCR/todo.md"
fi
