#!/usr/bin/env bash

export SETUP_CFG="cron"

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-check file $0 "$config_fld/crontab"
x-utils-cmd-install crontab cronie
set +e

crontab_tmp="/tmp/crontab"

envsubst < "$config_fld/crontab" > "$crontab_tmp"
nano "$crontab_tmp"
crontab "$crontab_tmp"
rm "$crontab_tmp"

systemctl enable cronie.service
systemctl restart cronie.service
