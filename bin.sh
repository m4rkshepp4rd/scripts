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

aliases="$HOME/.config/.bin-aliases"
rm "$aliases"
for bin in $(find "$MS_SCR" -name ".*" -prune -o -type f -not -name '.*' | grep -v ".*\.git.*"); do
    bin_subpath="${bin#$MS_SCR/}"
    bin_name="${bin_subpath%.*}"
    bin_name="${bin_name/\//-}"
    bin_path="$MS_LOCAL_BIN/x-$bin_name"
    cp "$bin" "$bin_path"
    chmod +x "$bin_path"
    case $bin_name in        
        setup-*) echo "alias xs-${bin_name#setup-}='x-$bin_name'" >> "$aliases" ;;
        symlinks-*) echo "alias xsm-${bin_name#symlinks-}='x-$bin_name'" >> "$aliases" ;;
        gnome-manjaro-*) echo "alias xg-${bin_name#gnome-manjaro-}='x-$bin_name'" >> "$aliases" ;;
        utils-*) echo "alias xu-${bin_name#utils-}='x-$bin_name'" >> "$aliases" ;;
        vaults-*) echo "alias xv-${bin_name#vaults-}='x-$bin_name'" >> "$aliases" ;;
        omarchy-*) echo "alias xo-${bin_name#omarchy-}='x-$bin_name'" >> "$aliases" ;;
    esac
    echo "$(basename $0): created binary ${bin_path}"
done
