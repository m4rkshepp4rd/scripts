#!/usr/bin/env bash

mount_point="$1"
vault_path="$2"

set -e
x-utils-check var $0 MS_GPG_PASS mount_point vault_path
set +e

mkdir -p "$mount_point"
cryptomator-cli unlock --password:file="$MS_GPG_PASS" --mounter=org.cryptomator.frontend.fuse.mount.LinuxFuseMountProvider --mountPoint="$mount_point" "$vault_path"

