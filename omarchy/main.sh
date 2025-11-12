#!/usr/bin/env bash

# should be located in /omarchy
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )

MS_DOCS="$HOME/Documents/docs"

bash $SCRIPT_DIR/setup/apps.sh

echo "Apps installed"
sleep 2
clear
echo "Yandex.Disk setup..."

bash $SCRIPT_DIR/setup/yandex-disk.sh

echo "Yandex.Disk has been set up"
echo "Waiting for files to download..."

yd_status=""
while [[ $yd_status != "idle" ]]
do
    sleep 10
    clear
    ydtmp=$(yandex-disk status | grep status:)
    yd_status=${ydtmp##* }
    echo "Sync status: $yd_status"
    echo "$(yandex-disk status | head -n 1)"
    echo "Waiting for files to download..."
done
echo "Files have been downloaded"
sleep 3
clear

# echo "Installing Cryptomator"
# bash $SCRIPT_DIR/setup/cryptomator.sh
# echo "Cryptomator is installed"
mkdir -p "$MS_DOCS"
echo "Waiting for Cryptomator _docs vault to be unlocked..."
echo "Use cryptomator-cli unlock --password:stdin --mounter=org.cryptomator.frontend.fuse.mount.LinuxFuseMountProvider --mountPoint="$MS_DOCS" "$HOME/Yandex.Disk/_docs""

cryptomator_unlocked="0"
while [[ $cryptomator_unlocked == "0" ]]
do
    sleep 10
    clear
    cryptomator_unlocked="$(ls $MS_DOCS | wc -l)"
    echo "Waiting for Cryptomator to be unlocked..."
    echo "Use cryptomator-cli unlock --password:stdin --mounter=org.cryptomator.frontend.fuse.mount.LinuxFuseMountProvider --mountPoint="$MS_DOCS" "$HOME/Yandex.Disk/_docs""
done
echo "Cryptomator has been unlocked"
sleep 2
clear

echo "Setting up and running custom scripts"

source $MS_DOCS/configs/env/.sharenv

bash $SCRIPT_DIR/setup/env.sh
bash $SCRIPT_DIR/setup/zsh.sh -f
bash $SCRIPT_DIR/setup/bash.sh

bash $SCRIPT_DIR/chmodx.sh
bash $SCRIPT_DIR/bin.sh
bash $SCRIPT_DIR/index.sh
bash $SCRIPT_DIR/symlinks/base.sh
bash $SCRIPT_DIR/symlinks/x.sh -l
bash $SCRIPT_DIR/setup/cron.sh
# bash $SCRIPT_DIR/symlinks/docs.sh
bash $SCRIPT_DIR/setup/vscode.sh
bash $SCRIPT_DIR/setup/onlyoffice.sh
# bash $SCRIPT_DIR/setup/flameshot.sh
bash $SCRIPT_DIR/setup/telegram.sh
bash $SCRIPT_DIR/setup/tmux.sh
bash $SCRIPT_DIR/setup/hyprland.sh
bash $SCRIPT_DIR/setup/nautilus.sh
bash $SCRIPT_DIR/setup/default-apps.sh

bash $SCRIPT_DIR/setup/pyvenv.sh x

sudo systemctl restart input-remapper
sudo systemctl enable input-remapper

bash $SCRIPT_DIR/omarchy/cleanup.sh

clear
echo "Linux setup is done! Rebooting in 1 minute"
sleep 60
sudo systemctl reboot
