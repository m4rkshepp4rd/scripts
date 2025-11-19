#!/usr/bin/env bash

if [[ " $* " == *" -h "* ]]; then
    echo "-r --remove     Removes current monitors setup"
    echo "-d --default    Removes current monitors setup"
    exit 0
fi

templates_fld="$HOME/.config/hypr/monitors"
cur_conf="$templates_fld/current.conf"

if x-utils-has-flag ";*" -r --remove -d --default; then
    rm "$cur_conf" &> /dev/null
    touch "$cur_conf"
    exit 0
fi

if ! command -v hyprctl &> /dev/null; then
    echo "$(basename $2): hypr does not installed" >&2
    exit 1
fi

set -e
export preset_name="$1"
export preset_file="$templates_fld/$preset_name.conf"
x-utils-check var $0 preset_name
x-utils-check dir $0 "$templates_fld"
x-utils-check file $0 "$preset_file"
set +e

rm "$cur_conf" &> /dev/null
ln -s "$templates_fld/$1.conf" "$cur_conf"

hyprctl reload
