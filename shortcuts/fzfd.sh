#!/usr/bin/env bash

f="$(fzf)"
if [[ -d $f ]]; then
	setsid xdg-open "$f"
else
	setsid xdg-open "$(dirname $f)"
fi

# xdg-open "$(dirname "$(fzf)")">/dev/null 2>&1