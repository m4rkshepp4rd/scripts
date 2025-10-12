#!/usr/bin/env bash

if [[ -z $1 ]]; then
    echo "($(basename $0))" "enter path"
    exit 1
fi

for path in $(find $1 -name '*'); do
    if [[ -f ${path} ]]; then
        chmod 600 ${path}
        echo "($(basename $0))" "chmod 600 ${path}"
    fi
    if [[ -d ${path} ]]; then
        chmod 700 ${path}
        echo "($(basename $0))" "chmod 700 ${path}"
    fi
done