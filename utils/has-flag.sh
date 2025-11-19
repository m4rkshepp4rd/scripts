#!/usr/bin/env bash

for f in "${@:2}"; do
    [[ " $1 " =~ [[:space:]]${f}[[:space:]] ]] && exit 0
done

exit 1
