#!/usr/bin/env bash

if [[ " $* " == *" -h "* ]]; then
    echo "-i --id-rsa    copies (created or existing key) to ~/.ssh/id_rsa"
    exit 0
fi

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

if x-utils-has-flag "$*" -i --id-rsa; then
    cp -f "$key_fld/ssh-key" "$DEST/id_rsa"
fi

x-utils-chmod700 "$DEST"
set +e
