#!/usr/bin/env bash

if [[ -z $MS_YD ]]; then
    echo "($(basename $0))" "Env var MS_YD not defined"
    exit 1
fi

if [[ -z $MS_GPG_PASS ]]; then
    echo "($(basename $0))" "Env var MS_GPG_PASS not defined"
    exit 1
fi

cryptomator-cli unlock --password:file="$MS_GPG_PASS" --mounter=org.cryptomator.frontend.fuse.mount.LinuxFuseMountProvider --mountPoint="$HOME/Documents/Photos" "$MS_YD/_photo"