#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

config_fld="$MS_CFG/vscode"

no_ext="0"
rm_ext="0"

get_args() {
	if [[ ! -z $1 ]]; then
		if [[ $1 == "--no-ext" ]]; then
			no_ext="1"
		elif [[ $1 == "--rm-ext" ]]; then
			rm_ext="1"
		else
			if [[ -d $1 ]]; then
				config_fld="$1"
			fi
		fi
	fi
}

get_args $1
get_args $2
get_args $3


bin_path="$(which code-insiders)"
if [[ -z $bin_path ]]; then
    paru -Sy visual-studio-code-insiders-bin
fi

if [[ ! -d $config_fld ]]; then
    echo "($(basename $0))" "Config folder not found"
	exit 1
fi

if [[ $rm_ext == "1" ]]; then
	for ext in $(code-insiders --list-extensions); do
		code-insiders --uninstall-extension $ext
	done
fi

if [[ $no_ext == "0" ]]; then
	while read ext; do
		code-insiders --install-extension $ext
	done < "$config_fld/extensions.txt"
fi

mkdir -p "$HOME/.config/Code - Insiders/User"
cp -f "$config_fld/settings.json" $HOME/.config/Code\ -\ Insiders/User/settings.json

