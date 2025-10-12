#!/usr/bin/env bash


if [[ -z $MS_GPG_PASS ]]; then
    echo "($(basename $0))" "Env var MS_GPG_PASS not defined"
    exit 1
fi

if [[ ! -f $MS_GPG_PASS ]]; then
    echo "($(basename $0))" "Passpharase file not found"
    exit 1
fi

if [[ -z $1 ]]; then
    echo "($(basename $0))" "enter source path"
    exit 1
fi

SOURCE=$1
if [[ -z $2 ]]; then
    echo "($(basename $0))" "enter target path"
    exit 1
fi

TARGET=$2
mkdir -p ${TARGET}
for path in ${SOURCE}/*; do
    base=$(basename -- "${path}")
    echo "($(basename $0))" "encrypting ${path}"
    if [[ -d ${path} ]]; then
        cd $path/..
        # zip -r -X /tmp/${base}.zip ${path}
        zip -rqX /tmp/${base}.zip ${base}
        if ! test -f "${TARGET}/${base}.sha1" || [ "$(sha1sum /tmp/${base}.zip | cut -d " " -f 1)" != "$(cat ${TARGET}/${base}.sha1)" ]; then
            echo "($(basename $0))" "$base changed"
            rm "${TARGET}/${base}.gpg.fld"
            gpg --batch --passphrase-file "${MS_GPG_PASS}" -o "${TARGET}/${base}.gpg.fld" -c /tmp/${base}.zip
            sha1sum /tmp/${base}.zip | cut -d " " -f 1 > "${TARGET}/${base}.sha1"
        fi
        rm "/tmp/${base}.zip"
    fi
    if [[ -f ${path} ]]; then
        if ! test -f "${TARGET}/${base}.sha1" || [ "$(sha1sum ${path} | cut -d " " -f 1)" != "$(cat ${TARGET}/${base}.sha1)" ]; then
            echo "($(basename $0))" "$base changed"
            rm "${TARGET}/${base}.gpg"
            gpg --batch --passphrase-file "${MS_GPG_PASS}" -o "${TARGET}/${base}.gpg" -c ${path}
            sha1sum ${path} | cut -d " " -f 1 > "${TARGET}/${base}.sha1"
        fi
    fi
done
