#!/usr/bin/env bash

set -e
export cmd="$1"
x-utils-check var $0 cmd
set +e

if [[ -n $2 ]]; then
    package="$2"
else
    package="$1"
fi

command -v "$cmd" &> /dev/null && exit 0

paru -Sy --noconfirm "$package"
