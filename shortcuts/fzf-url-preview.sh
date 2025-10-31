#!/usr/bin/env bash

if [[ -z $MS_BROWSER ]]; then
    echo "($(basename $0))" "Env var MS_BROWSER not defined"
    exit 1
fi

if [[ -z $1 && ! -f $1 ]]; then
    echo "($(basename $0))" "File $1 not found for fzf"
    exit 1
fi

if [[ -z $2 ]]; then
    browser=$MS_BROWSER
fi

browser=$2

page=$(cat $1 | fzf --preview='rich $(echo "($(basename $0))" {} | awk "{print \$(NF-1)}") --force-terminal' --preview-window 'top:70%')

if [ -n "$page" ]; then
    page_url="${page##*|}"
    setsid $browser $(echo "$page_url")
fi

