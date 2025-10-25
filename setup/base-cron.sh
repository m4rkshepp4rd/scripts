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


crontab_tmp="/tmp/crontab"


sudo echo "BASH_ENV=$HOME/.sharenv" >> $crontab_tmp
sudo echo "*/5 * * * * $MS_LOCAL_BIN/x-index" >> $crontab_tmp
sudo echo "*/10 * * * * $MS_LOCAL_BIN/x-cfg-backups" >> $crontab_tmp
sudo echo "*/10 * * * * $MS_LOCAL_BIN/x-symlinks-docs" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-jira-crawl" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-confluence-crawl" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-gpg $MS_DOCS $MS_YD_GPG/docs" >> $crontab_tmp
sudo echo "# */30 * * * * $MS_LOCAL_BIN/x-gpg $HOME/Documents/projects $MS_YD_GPG/projects" >> $crontab_tmp
sudo echo "# 10,20,40,50 * * * * export $(dbus-launch) && source /home/user/.sharenv && /home/user/.local/bin/x-gnome-menu && kill -9 '$DBUS_SESSION_BUS_PID'" >> $crontab_tmp
crontab $crontab_tmp
rm $crontab_tmp

systemctl enable cronie.service
systemctl restart cronie.service
