#!/usr/bin/env bash

if x-utils-has-flag "$*" -h --help; then
    echo "-l --symlinks    creates useful symlinks for the scripts project"
    exit 0
fi

set -e
x-utils-check var $0 MS_SCR
set +e

rm -rf "$HOME/.x"
ln -s "$MS_SCR" "$HOME/.x"

if x-utils-has-flag "$*" -l --symlinks; then
    set -e
    x-utils-check var $0 MS_DOCS
    set +e
    rm "$MS_SCR/_configs"
    ln -s "$MS_DOCS/configs" "$MS_SCR/_configs"
    rm "$MS_SCR/_cfg-backups"
    ln -s "$MS_DOCS/cfg-backups" "$MS_SCR/_cfg-backups"
    rm "$MS_SCR/todo.md"
    ln -s "$MS_DOCS/todo.md" "$MS_SCR/todo.md"
fi
