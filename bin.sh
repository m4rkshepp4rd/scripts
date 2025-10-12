#!/usr/bin/env bash


if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi

if [[ -z $MS_LOCAL_BIN ]]; then
    echo "($(basename $0))" "Env var MS_LOCAL_BIN not defined"
    exit 1
fi

if [[ ! -d $MS_SCR ]]; then
    echo "($(basename $0))" "Scripts folder not found"
    exit 1
fi

mkdir -p "${MS_LOCAL_BIN}"
for path in ${MS_LOCAL_BIN}/*; do
    path_base=${path##*/}
    if [[ "$path_base" == x-* ]]; then
        rm "$path"
    fi
done


for path in ${MS_SCR}/*; do
    path_base=${path##*/}
    if [[ $path_base != "_configs" && $path_base != "_config-backups" ]];then
        if [[ -d ${path} ]]; then
            for subpath in ${path}/*; do
                    subpath_base=${subpath##*/}
                    bin_path="${MS_LOCAL_BIN}/x-${path_base}-${subpath_base%.*}"
                    cat ${subpath} > ${bin_path}
                    chmod +x ${bin_path}
                    echo "($(basename $0))" "created binary ${bin_path}"
            done
        fi
        if [[ -f ${path} ]]; then
            bin_path="${MS_LOCAL_BIN}/x-${path_base%.*}"
            cat ${path} > ${bin_path}
            chmod +x ${bin_path}
            echo "($(basename $0))" "created binary ${bin_path}"
        fi
    fi
done