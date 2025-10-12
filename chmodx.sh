#!/usr/bin/env bash


if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi


SCRIPTS_PATH="$MS_SCR"

if [[ ! -d $SCRIPTS_PATH ]]; then
    echo "($(basename $0))" "Scripts folder not found"
    exit 1
fi

for path in $(find ${SCRIPTS_PATH} -name '*'); do
    if [[ -f ${path} ]]; then
        echo "($(basename $0))" "chmod +x ${path}"
        chmod +x ${path}
    fi
done

