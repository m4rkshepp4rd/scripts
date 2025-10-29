#!/usr/bin/env bash

gnome_desktop="org.gnome.desktop"

pic="$(realpath $1)"

if [[ ! -z $pic  && -f $pic ]]; then
    gsettings set "$gnome_desktop.background" picture-uri "file://$pic"
    gsettings set "$gnome_desktop.background" picture-uri-dark "file://$pic"
fi