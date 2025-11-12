#!/usr/bin/env bash

if [[ -z $MS_LOCAL_BIN ]]; then
    echo "($(basename $0))" "Env var MS_LOCAL_BIN not defined"
    exit 1
fi

if [[ -z $MS_DOCS ]]; then
    echo "($(basename $0))" "Env var MS_DOCS not defined"
    exit 1
fi

if [[ -z $MS_YD_GPG ]]; then
    echo "($(basename $0))" "Env var MS_YD_GPG not defined"
    exit 1
fi

if ! command -v "crontab" &> /dev/null; then
    paru -Sy cronie
fi

crontab_tmp="/tmp/crontab"

sudo echo "BASH_ENV=$HOME/.sharenv" >> $crontab_tmp
sudo echo "*/5 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-index" >> $crontab_tmp
sudo echo "*/10 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-cfg-backups" >> $crontab_tmp
sudo echo "# */10 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-symlinks-docs" >> $crontab_tmp
sudo echo "# */30 * * * * source $HOME/.sharenv && $MS_LOCAL_BIN/x-utils-cron-wrapper x-jira-crawl" >> $crontab_tmp
sudo echo "# */30 * * * * source $HOME/.sharenv && $MS_LOCAL_BIN/x-utils-cron-wrapper x-confluence-crawl" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-gpg $MS_DOCS $MS_YD_GPG/docs" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-gpg $HOME/Documents/projects $MS_YD_GPG/projects" >> $crontab_tmp
crontab $crontab_tmp
rm $crontab_tmp

systemctl enable cronie.service
systemctl restart cronie.service
