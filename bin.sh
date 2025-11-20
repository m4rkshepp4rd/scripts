#!/usr/bin/env bash

if [[ -z $MS_SCR || -z $MS_LOCAL_BIN || ! -d "$MS_SCR" ]]; then
    echo "$(basename $0): No can do, check vars" >&2
    exit 1
fi

mkdir -p "${MS_LOCAL_BIN}"
rm $MS_LOCAL_BIN/x-*
rm $MS_LOCAL_BIN/xs-*
rm $MS_LOCAL_BIN/xsm-*
rm $MS_LOCAL_BIN/xg-*
rm $MS_LOCAL_BIN/xu-*
rm $MS_LOCAL_BIN/xv-*
rm $MS_LOCAL_BIN/xo-*

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
        vaults-*) ln -s "$bin_path" "$MS_LOCAL_BIN/xv-${bin_name#vaults-}" ;;
        omarchy-*) ln -s "$bin_path" "$MS_LOCAL_BIN/xo-${bin_name#omarchy-}" ;;
    esac
    echo "$(basename $0): created binary ${bin_path}"
done
