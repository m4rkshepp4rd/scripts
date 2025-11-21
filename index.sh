#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_FINDINDEX MS_FINDINDEX_DIRS MS_SYMPATHS MS_YD MS_APPS
set +e

find $HOME -path "$MS_YD/_*" -o -path "$HOME/.local/share/Trash/*" -prune -o -print | sort > /tmp/.findindex
find / -path "$HOME/*" -o -path "/run/*" -o -path "/proc/*" -prune -o -print | sort >> /tmp/.findindex

while IFS= read -r f; do
    if [[ -d "$f" ]]; then
        echo "$f"
    fi
done < /tmp/.findindex > /tmp/.findindex-dirs

while IFS= read -r dir; do
    if [[ -f "$dir/.sympath" && ! -L "$dir" ]]; then
        echo "$dir"
    fi
done < /tmp/.findindex-dirs > /tmp/.sympaths

names=()
while read file; do
    name=$(grep -E "^Name=" "$file" | head -1 | cut -d= -f2)
    no_display=$(grep -E "^NoDisplay=" "$file" | head -1 | cut -d= -f2)
    if [[ ! -z "$name" && ! " ${names[*]} " =~ " $name " ]]; then
        [[ "$no_display" != "true" ]] && echo -n "$name" &&  printf '%*s' 100 && echo "| $file" && names+=("$name")
    fi
done < <(find /usr/share/applications /usr/local/share/applications "$HOME/.local/share/applications" -name "*.desktop" 2>/dev/null) | sort > "/tmp/.desktop-apps"

cp -f /tmp/.findindex "$MS_FINDINDEX"
cp -f /tmp/.findindex-dirs "$MS_FINDINDEX_DIRS"
cp -f /tmp/.sympaths "$MS_SYMPATHS"
cp -f /tmp/.desktop-apps "$MS_APPS"
rm /tmp/.findindex
rm /tmp/.findindex-dirs
rm /tmp/.sympaths
rm /tmp/.desktop-apps

