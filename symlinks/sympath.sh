#!/usr/bin/env bash

set -e
export source="$1"
x-utils-check var $0 source MS_SYMPATHS
set +e

if ! x-utils-check dir $0 "$source" 2> /dev/null; then
    if cat "$MS_SYMPATHS" | grep "$source" &> /dev/null; then
        export source=$(cat "$MS_SYMPATHS" | grep "$source" | head -n 1)
    else
        echo "$(basename $0): Source for symlink not found" >&2
        exit 1
    fi
fi

set -e
x-utils-check file $0 "$source/.sympath"
set +e

path=$(<"$source/.sympath")
expanded_path=$(echo "$path" | envsubst)

x-utils-symlink-update "$source" "$expanded_path"
