#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_APPS
set +e

names=()
while read file; do
    name=$(grep -E "^Name=" "$file" | head -1 | cut -d= -f2)
    no_display=$(grep -E "^NoDisplay=" "$file" | head -1 | cut -d= -f2)
    if [[ ! -z "$name" && ! " ${names[*]} " =~ " $name " ]]; then
        [[ "$no_display" != "true" ]] && echo -n "$name" &&  printf '%*s' $((70-${#name})) && echo "| $file" && names+=("$name")
    fi
done < <(find /usr/share/applications /usr/local/share/applications "$HOME/.local/share/applications" -name "*.desktop" 2>/dev/null) | sort > "/tmp/.desktop-apps"

cp -f /tmp/.desktop-apps "$MS_APPS"
rm /tmp/.desktop-apps

