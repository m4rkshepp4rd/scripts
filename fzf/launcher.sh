#!/usr/bin/env bash

# Configuration

set -e
x-utils-check var $0 MS_BROWSER MS_APPS
set +e

BROWSER="$MS_BROWSER"
SEARCH_ENGINE="https://google.com/search?q="

INPUT=$(cat "$MS_APPS" | fzf --print-query -e -i --preview='echo {1} && cat {2} | grep -E "^Comment=" | head -1 | cut -d= -f2' --delimiter=' \| ' --preview-window 'bottom:40%' --prompt "🔍Apps > ")

if [ -z "$INPUT" ]; then
    exit 0
fi

desktop="${INPUT##*/}"

if cat "$MS_APPS" | grep "$desktop" &> /dev/null; then
    setsid gtk-launch "$desktop"
    sleep 0.1
else
    setsid $BROWSER "${SEARCH_ENGINE}${INPUT}"
fi