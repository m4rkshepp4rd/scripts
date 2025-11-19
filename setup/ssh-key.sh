#!/usr/bin/env bash

export SETUP_CFG="ssh"
DEST="$HOME/.ssh"

set -e
export key_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 key_fld

if [[ ! -d "$DEST" ]]; then
    mkdir "$DEST"
fi

if [[ ! -d "$key_fld" ]]; then
    mkdir -p "$key_fld"
    ssh-keygen -t rsa -b 4096 -f "$key_fld/ssh-key"
fi

x-utils-check file $0 "$key_fld/ssh-key"
profile="${key_fld##*/}"
cp -f "$key_fld/ssh-key" "$DEST/$profile.key"

[[ "$*" == *" -i "* ]] && cp -f "$key_fld/ssh-key" "$DEST/id_rsa"

x-utils-chmod700 "$DEST"
set +e
