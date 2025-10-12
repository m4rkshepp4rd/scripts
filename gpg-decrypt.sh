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
source_base=$(basename -- $SOURCE)
mkdir -p "/tmp/$source_base/"
mkdir -p $TARGET
for path in ${SOURCE}/*.gpg; do
    path_part=${path##*/}
    base=${path_part%.*}
    gpg --batch --passphrase-file $MS_GPG_PASS -o $TARGET/$base -d ${path}
    # unzip ${tmp_path} -d $TARGET
done

for path in ${SOURCE}/*.gpg.fld; do
    path_part=${path##*/}
    base=${path_part%.*}
    tmp_path="/tmp/$source_base/$base"
    gpg --batch --passphrase-file $MS_GPG_PASS -o ${tmp_path} -d ${path}
    unzip -o ${tmp_path} -d $TARGET
done

rm -rf "/tmp/$source_base/"
    