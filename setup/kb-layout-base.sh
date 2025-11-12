#!/usr/bin/env bash

if [[ $XDG_CURRENT_DESKTOP == "GNOME" ]]; then
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"
fi

if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
    hyprctl keyword input:kb_layout us &> /dev/null
    hyprctl keyword input:kb_layout us,ru &> /dev/null
fi
