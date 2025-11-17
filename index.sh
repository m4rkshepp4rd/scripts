#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_FINDINDEX MS_FINDINDEX_DIRS MS_SYMPATHS MS_YD
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

# sed 's/^/"/; s/$/"/' /tmp/.findindex | xargs dirname | sort -u | grep '^/' > /tmp/.findindex-dirs
# sed 's/^/"/; s/$/"/' /tmp/.findindex-dirs | xargs -I {} ls -A "{}/.sympath" 2> /dev/null | xargs dirname > $MS_SYMPATHS

cp -f /tmp/.findindex "$MS_FINDINDEX"
cp -f /tmp/.findindex-dirs "$MS_FINDINDEX_DIRS"
cp -f /tmp/.sympaths "$MS_SYMPATHS"
rm /tmp/.findindex
rm /tmp/.findindex-dirs
rm /tmp/.sympaths

