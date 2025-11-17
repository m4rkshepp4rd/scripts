#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_YD_SYNC
set +e

base=(syncdata books cv articles edu input-remapper)
for p in "${base[@]}"; do
    x-symlinks-sympath "$p"
done
