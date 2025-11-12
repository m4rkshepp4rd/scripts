#!/usr/bin/env bash

# $1 - check type
# $2 - script name for which error is displayed

if [[ -z $1 ]]; then
    echo "$(basename $0): Empty args" >&2
    exit 1
fi

case $1 in
    var) 
        for var in "${@:3}"; do
            if [[ -z ${!var} ]]; then
                echo "$(basename $2): Env var \"$var\" not defined" >&2
                exit 1
            fi
        done
        ;;
    file) 
        for var in "${@:3}"; do
            if [[ ! -f $var ]]; then
                echo "$(basename $2): File \"$var\" does not exist" >&2
                exit 1
            fi
        done
        ;;
    dir) 
        for var in "${@:3}"; do
            if [[ ! -d $var ]]; then
                echo "$(basename $2): Directory \"$var\" does not exist" >&2
                exit 1
            fi
        done
        ;;
    *) echo "$(basename $0): Wrong check type" >&2 && exit 1 ;;
esac

