#!/usr/bin/env bash


if ! command -v "$1" &> /dev/null; then
    echo "$(basename $0): Script not found" >&2
    exit 1
fi

cmd=$(command -v "$1")

set -e
x-utils-check exe $0 "$cmd"
set +e

[ -f $HOME/.config/.sharenv ] && source $HOME/.config/.sharenv
$cmd "${@:2}"
exit_code=$?

echo "$(basename $0): $@ finished with exit code $exit_code"
exit $exit_code
