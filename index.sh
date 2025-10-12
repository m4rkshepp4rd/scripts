#!/usr/bin/env bash

if [[ -z $MS_FINDINDEX ]]; then
    echo "($(basename $0))" "Env var MS_FINDINDEX not defined"
    exit 1
fi

if [[ -z $MS_YD ]]; then
    echo "($(basename $0))" "Env var MS_YD not defined"
    exit 1
fi

find $HOME -path "$MS_YD/_*" -prune -o -print | sort > /tmp/.findindex
find / -path "$HOME/*" -o -path "/run/*" -o -path "/proc/*" -prune -o -print | sort >> /tmp/.findindex
cp -f /tmp/.findindex $MS_FINDINDEX
sed 's/^/"/; s/$/"/' /tmp/.findindex | xargs dirname | sort -u | grep '^/' > $MS_FINDINDEX_DIRS
rm /tmp/.findindex
