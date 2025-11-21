#!/usr/bin/env bash

f=$(fzf)
if [ -n "$f" ]; then
    if [[ -d "$f" ]]; then
		setsid xdg-open "$f" &
	else
		setsid xdg-open "$(dirname "$f")" &
	fi
	sleep 0.1
fi
exit 0
