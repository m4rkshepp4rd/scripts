#!/usr/bin/env bash


if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi

if [[ -z $MS_LOCAL_BIN ]]; then
    echo "($(basename $0))" "Env var MS_LOCAL_BIN not defined"
    exit 1
fi

if [[ ! -d $MS_SCR ]]; then
    echo "($(basename $0))" "Scripts folder not found"
    exit 1
fi

mkdir -p "${MS_LOCAL_BIN}"
rm $MS_LOCAL_BIN/x-*
rm $MS_LOCAL_BIN/xs-*
rm $MS_LOCAL_BIN/xsm-*
rm $MS_LOCAL_BIN/xg-*

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
    esac
    echo "($(basename $0))" "created binary ${bin_path}"
done
