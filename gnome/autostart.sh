#!/usr/bin/env bash


# Autostart
sed 's/Exec=copyq --start-server show/Exec=copyq --start-server/' /usr/share/applications/com.github.hluk.copyq.desktop > $HOME/.config/autostart/com.github.hluk.copyq.desktop

