#!/usr/bin/env bash

pop_shell_schemas="$HOME/.local/share/gnome-shell/extensions/pop-shell@system76.com/schemas"
pop_shell_settings="org.gnome.shell.extensions.pop-shell"

gsettings set org.gnome.shell disable-user-extensions false

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings toggle-tiling "['']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings toggle-floating "['<Super>f']"

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings mouse-cursor-follows-active-window false

# Tiling
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-by-default true
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings gap-outer 1
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings gap-inner 3
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings active-hint true
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings active-hint-border-radius 10
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings hint-color-rgba "rgba(0,220,0,1)"

# Focus
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-enter "['<Super>u']"

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings focus-down "['<Super>k']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings focus-up "['<Super>i']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings focus-left "['<Super>j']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings focus-right "['<Super>l']"

# Move
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-down-global "['<Control>k']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-up-global "['<Control>i']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-left-global "['<Control>j']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-right-global "['<Control>l']"

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-down "['k']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-up "['i']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-left "['j']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-move-right "['l']"

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-resize-down "['<Shift>i']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-resize-up "['<Shift>k']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-resize-left "['<Shift>j']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-resize-right "['<Shift>l']"

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings toggle-stacking-global "['<Super>o']"
gsettings --schemadir $pop_shell_schemas set $pop_shell_settings tile-orientation "['<Super>p']"

gsettings --schemadir $pop_shell_schemas set $pop_shell_settings activate-launcher "['']"



gtlw_schemas="$HOME/.local/share/gnome-shell/extensions/gnome-shell-go-to-last-workspace@github.com/schemas"
gtlw_settings="org.gnome.shell.extensions.go-to-last-workspace"
gsettings --schemadir $gtlw_schemas set $gtlw_settings shortcut-key "['<Alt>s']"

batind_schemas="$HOME/.local/share/gnome-shell/extensions/bluetooth-battery@michalw.github.com/schemas"
batind_settings="org.gnome.shell.extensions.bluetooth_battery_indicator"
gsettings --schemadir $batind_schemas set $batind_settings interval 1
gsettings --schemadir $batind_schemas set $batind_settings hide-indicator true


gnome-extensions enable pop-shell@system76.com
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable gnome-shell-go-to-last-workspace@github.com
gnome-extensions enable bluetooth-battery@michalw.github.com
gnome-extensions enable system-monitor@gnome-shell-extensions.gcampax.github.com
