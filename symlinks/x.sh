#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_SCR
set +e

rm -rf "$HOME/.x"
ln -s "$MS_SCR" "$HOME/.x"

if [[ " $* " == *" -l "* ]]; then
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
