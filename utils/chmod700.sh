#!/usr/bin/env bash


set -e
export chmod_path="$1"
x-utils-check var $0 chmod_path
set +e

for path in $(find $chmod_path -name '*'); do
    if [[ -f "$path" ]]; then
        chmod 600 "$path"
        echo "$(basename $0): chmod 600 $path"
    fi
    if [[ -d "$path" ]]; then
        chmod 700 "$path"
        echo "$(basename $0): chmod 700 $path"
    fi
done
