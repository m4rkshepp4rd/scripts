#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_SCR MS_LOCAL_BIN
x-utils-check dir $0 $MS_SCR
set +e

mkdir -p "${MS_LOCAL_BIN}"
rm $MS_LOCAL_BIN/x-*
rm $MS_LOCAL_BIN/xs-*
rm $MS_LOCAL_BIN/xsm-*
rm $MS_LOCAL_BIN/xg-*
rm $MS_LOCAL_BIN/xu-*

for bin in $(find "$MS_SCR" -name ".*" -prune -o -type f -not -name '.*' | grep -v ".*\.git.*"); do
    bin_subpath="${bin#$MS_SCR/}"
    bin_name="${bin_subpath%.*}"
    bin_name="${bin_name/\//-}"
    bin_path="$MS_LOCAL_BIN/x-$bin_name"
    cp "$bin" "$bin_path"
    chmod +x "$bin_path"
    case $bin_name in
        setup-*) ln -s "$bin_path" "$MS_LOCAL_BIN/xs-${bin_name#setup-}" ;;
        symlinks-*) ln -s "$bin_path" "$MS_LOCAL_BIN/xsm-${bin_name#symlinks-}" ;;
        gnome-manjaro-*) ln -s "$bin_path" "$MS_LOCAL_BIN/xg-${bin_name#gnome-manjaro-}" ;;
        utils-*) ln -s "$bin_path" "$MS_LOCAL_BIN/xu-${bin_name#utils-}" ;;
    esac
    echo "$(basename $0): " "created binary ${bin_path}"
done
