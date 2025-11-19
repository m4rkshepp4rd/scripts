#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_LOCAL_BIN MS_DOCS MS_YD_GPG

x-utils-cmd-install crontab cronie
set +e

crontab_tmp="/tmp/crontab"

sudo echo "*/5 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-index" >> $crontab_tmp
sudo echo "*/10 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-cfg-backups" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-jira-crawl" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-confluence-crawl" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-gpg $MS_DOCS $MS_YD_GPG/docs" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-utils-cron-wrapper x-gpg $HOME/Documents/projects $MS_YD_GPG/projects" >> $crontab_tmp
crontab $crontab_tmp
rm $crontab_tmp

systemctl enable cronie.service
systemctl restart cronie.service
