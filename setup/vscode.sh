#!/usr/bin/env bash

export SETUP_CFG="vscode"
CMD="code-insiders"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-check dir $0 "$config_fld"
set +e

x-utils-cmd-install $CMD visual-studio-code-insiders-bin

if [[ "$*" == *" -r "*  || "$*" == *" --rm-ext "* || "${@: -1}" == "-r" || "${@: -1}" == "--rm-ext" ]]; then
	for ext in $(code-insiders --list-extensions); do
		code-insiders --uninstall-extension $ext
	done
fi

if [[ "$*" != *" -c "*  && "$*" != *" --no-cfg "* && "${@: -1}" != "-c" && "${@: -1}" != "--no-cfg" ]]; then
	x-utils-check file $0 "$config_fld/settings.json" || exit 1
	mkdir -p "$HOME/.config/Code - Insiders/User"
	cp -f "$config_fld/settings.json" $HOME/.config/Code\ -\ Insiders/User/settings.json
fi

if [[ "$*" != *" -e "*  && "$*" != *" --no-ext "* && "${@: -1}" != "-e" && "${@: -1}" != "--no-ext" ]]; then
	x-utils-check file $0 "$config_fld/extensions.txt" || exit 1
	while read ext; do
		code-insiders --install-extension $ext
	done < "$config_fld/extensions.txt"
fi
