#!/usr/bin/env bash


if ! command -v "$1" &> /dev/null; then
    echo "$(basename $0)" "Script not found"
    exit 1
fi

cmd=$(command -v "$1")

if [[ ! -x "$cmd" ]]; then
    echo "$(basename $0)" "Script $cmd not executable"
    exit 1
fi

$cmd "${@:2}"
exit_code=$?

echo "$(basename $0)" "$@ finished with exit code $exit_code"
exit $exit_code
