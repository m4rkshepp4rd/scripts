#!/usr/bin/env bash

f=$(fzf)
if [ -n "$f" ]; then
    setsid vlc "$f" &
    sleep 0.1
fi
exit 0
# xdg-open "$(fzf)">/dev/null 2>&1
