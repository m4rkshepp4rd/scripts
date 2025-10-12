#!/usr/bin/env bash


# Pop shell
pop_shell_path="$HOME/.local/share/gnome-shell/extensions/pop-shell@system76.com"
pop_shell_repo="https://github.com/pop-os/shell.git"
rm -rf $pop_shell_path
git clone --depth=1 $pop_shell_repo
cd shell
make local-install
cd ..
rm -rf shell/

# Appindicator
appindicator_path="$HOME/.local/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com"
appindicator_repo="https://github.com/ubuntu/gnome-shell-extension-appindicator.git"
app_tmp="/tmp/g-s-appindicators-build"

paru -S meson ninja
rm -rf $appindicator_path
git clone --depth=1 $appindicator_repo
meson gnome-shell-extension-appindicator $app_tmp
ninja -C $app_tmp install
rm -rf gnome-shell-extension-appindicator/
rm -rf $app_tmp install/
paru -Rsu meson ninja


# Go To Last Workspace
gtlw_path="$HOME/.local/share/gnome-shell/extensions/gnome-shell-go-to-last-workspace@github.com/"
gtlw_repo="https://github.com/arjan/gnome-shell-go-to-last-workspace.git"

rm -rf $gtlw_path
git clone --depth=1 $gtlw_repo
cd gnome-shell-go-to-last-workspace
make install
cd ..
rm -rf gnome-shell-go-to-last-workspace/


# Battery Indicator
batind_path="$HOME/.local/share/gnome-shell/extensions/bluetooth-battery@michalw.github.com"
batind_repo="https://github.com/MichalW/gnome-bluetooth-battery-indicator.git"

rm -rf $batind_path
git clone --depth=1 $batind_repo
cp -r gnome-bluetooth-battery-indicator/ $batind_path
rm -rf gnome-bluetooth-battery-indicator/
