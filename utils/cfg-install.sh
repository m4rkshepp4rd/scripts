#!/usr/bin/env bash

# $1 - config
# $2 - destination

set -e
export cfg="$1"
export dest="$2"
x-utils-check var $0 cfg dest
x-utils-check file $0 "$cfg/.foolproof"
x-utils-check dir $0 "$cfg"
set +e

mkdir -p "$dest"
cp -rf "$cfg/." "$dest"
rm "$dest/.foolproof"
