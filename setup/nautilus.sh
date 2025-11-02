#!/usr/bin/env bash

nautilus="org.gnome.nautilus"
gsettings set "$nautilus.list-view" default-zoom-level 'small'
gsettings set "$nautilus.list-view" use-tree-view true
gsettings set "$nautilus.preferences" default-folder-viewer 'list-view'
gsettings set "$nautilus.preferences" show-hidden-files true

gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
