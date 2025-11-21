#!/usr/bin/env bash

f=$(fzf)
if [ -n "$f" ]; then
    setsid code-insiders "$f" &
    sleep 0.1
fi
exit 0

