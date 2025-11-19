#!/usr/bin/env bash

# $1 - config
# $2 - destination
if x-utils-has-flag "$*" -h --help; then
    echo "--no-fool    skips foolproof check"
    exit 0
fi

set -e
export cfg="$1"
export dest="$2"
x-utils-check var $0 cfg dest
if ! x-utils-has-flag "$*" --no-fool; then
    x-utils-check file $0 "$cfg/.foolproof"
fi
x-utils-check dir $0 "$cfg"
set +e

mkdir -p "$dest"
cp -rf "$cfg/." "$dest"
rm "$dest/.foolproof"
