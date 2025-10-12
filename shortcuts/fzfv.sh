#!/usr/bin/env bash

if [[ -z $MS_MEDIA ]]; then
    echo "($(basename $0))" "Env var MS_MEDIA not defined"
    exit 1
fi

setsid $MS_MEDIA "$(fzf)"

# xdg-open "$(fzf)">/dev/null 2>&1
