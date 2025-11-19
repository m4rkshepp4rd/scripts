#!/usr/bin/env bash

if [[ " $* " == *" -h "* ]]; then
    echo "-c --no-cfg    does not copy settings.json (does it by default)"
    echo "-e --no-ext    does not install extensions (does it by default)"
    echo "-r --rm-ext    removes extensions"
    exit 0
fi

export SETUP_CFG="vscode"
CMD="code-insiders"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-check dir $0 "$config_fld"
x-utils-cmd-install $CMD visual-studio-code-insiders-bin
set +e

if x-utils-has-flag "$*" -r --rm-ext; then
	for ext in $(code-insiders --list-extensions); do
		code-insiders --uninstall-extension $ext
	done
fi

if ! x-utils-has-flag "$*" -c --no-cfg; then
	x-utils-check file $0 "$config_fld/settings.json" || exit 1
	mkdir -p "$HOME/.config/Code - Insiders/User"
	cp -f "$config_fld/settings.json" $HOME/.config/Code\ -\ Insiders/User/settings.json
fi

if ! x-utils-has-flag "$*" -e --no-ext; then
	x-utils-check file $0 "$config_fld/extensions.txt" || exit 1
	while read ext; do
		code-insiders --install-extension $ext
	done < "$config_fld/extensions.txt"
fi
