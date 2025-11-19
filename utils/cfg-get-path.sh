#!/usr/bin/env bash

# $1 - config
# $2 - destination
if [[ " $* " == *" -h "* ]]; then
    echo "-p --profile    installs specific profile from config directory (just a subdir)"
    exit 0
fi

set -e
if [[ -n $1 && -d $1 ]]; then
    config_fld="$1"
else
    x-utils-check var $0 MS_CFG SETUP_CFG
    config_fld="$MS_CFG/$SETUP_CFG"
fi

if x-utils-has-flag "$*" -p --profile; then
    export profile="$2"
    x-utils-check var $0 profile
    config_fld="$config_fld/$profile"
fi
set +e

echo "$config_fld"
exit 0
