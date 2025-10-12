#!/usr/bin/env bash

if [[ -z $MS_BROWSER ]]; then
    echo "($(basename $0))" "Env var MS_BROWSER not defined"
    exit 1
fi

cryptopro_link="https://cryptopro.ru/sites/default/files/private/csp/50/13000/linux-amd64.tgz"

$MS_BROWSER $cryptopro_link