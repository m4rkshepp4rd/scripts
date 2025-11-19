#!/usr/bin/env bash

set -e
export source="$1"
export target="$2"
x-utils-check var $0 MS_GPG_PASS source target
x-utils-check file $0 "$MS_GPG_PASS"
x-utils-check dir $0 "$source"
set +e

target=$2
source_base=$(basename $source)
mkdir -p "/tmp/$source_base/"
mkdir -p $target
for path in $source/*.gpg; do
    path_part="${path##*/}"
    base="${path_part%.*}"
    gpg --batch --passphrase-file "$MS_GPG_PASS" -o "$target/$base" -d "$path"
done

for path in $source/*.gpg.fld; do
    path_part="${path##*/}"
    base="${path_part%.*}"
    tmp_path="/tmp/$source_base/$base"
    gpg --batch --passphrase-file "$MS_GPG_PASS" -o "$tmp_path" -d "$path"
    unzip -o "$tmp_path" -d "$target"
done

rm -rf "/tmp/$source_base/"
    