#!/usr/bin/env bash

set -e
export fzf_file="$1"
x-utils-check var $0 MS_BROWSER fzf_file
x-utils-check file $0 "$fzf_file"
set +e

if [[ -z $2 ]]; then
    browser=$MS_BROWSER
fi

browser=$2

page=$(cat $1 | fzf)
if [ -n "$page" ]; then
    page_url="${page##*|}"
    setsid $browser $(echo "$page_url")
fi