#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_FINDINDEX MS_YD
set +e

find $HOME -path "$MS_YD/_*" -prune -o -print | sort > /tmp/.findindex
find / -path "$HOME/*" -o -path "/run/*" -o -path "/proc/*" -prune -o -print | sort >> /tmp/.findindex
cp -f /tmp/.findindex $MS_FINDINDEX
sed 's/^/"/; s/$/"/' /tmp/.findindex | xargs dirname | sort -u | grep '^/' > $MS_FINDINDEX_DIRS
rm /tmp/.findindex
