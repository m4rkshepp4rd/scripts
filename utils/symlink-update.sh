#!/usr/bin/env bash

# $1 - source
# $2 - target

set -e
export source="$1"
export target="$2"
x-utils-check var $0 source target
x-utils-check path $0 "$source"
set +e

rm -rf "$target"

mkdir -p "$target"
rm -rf "$target"

ln -s "$(realpath $source)" "$target"
