#!/usr/bin/env bash

set -e
export source="$1"
export target="$2"
x-utils-check var $0 MS_GPG_PASS source target
x-utils-check file $0 "$MS_GPG_PASS"
x-utils-check dir $0 "$source"
set +e


mkdir -p $target
for path in $source/*; do
    base=$(basename "$path")
    echo "$(basename $0): encrypting $path"
    
    if [[ -d "$path" ]]; then
        cd $path/..
        zip -rqX /tmp/$base.zip "$base"
        if ! test -f "$target/$base.sha1" || [ "$(sha1sum /tmp/$base.zip | cut -d " " -f 1)" != "$(cat $target/$base.sha1)" ]; then
            echo "$(basename $0): $base changed"
            rm "$target/$base.gpg.fld"
            gpg --batch --passphrase-file "$MS_GPG_PASS" -o "$target/$base.gpg.fld" -c "/tmp/$base.zip"
            sha1sum /tmp/$base.zip | cut -d " " -f 1 > "$target/$base.sha1"
        fi
        rm "/tmp/$base.zip"
    fi
    if [[ -f "$path" ]]; then
        if ! test -f "$target/$base.sha1" || [ "$(sha1sum $path | cut -d " " -f 1)" != "$(cat $target/$base.sha1)" ]; then
            echo "$(basename $0): $base changed"
            rm "$target/$base.gpg"
            gpg --batch --passphrase-file "$MS_GPG_PASS" -o "$target/$base.gpg" -c "$path"
            sha1sum $path | cut -d " " -f 1 > "$target/$base.sha1"
        fi
    fi
done
