#!/usr/bin/env bash

hyprctl clients -j | jq ".[] | select(.class == \"$1\")" | grep "$1" &> /dev/null
exit $?
