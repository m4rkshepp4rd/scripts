#!/usr/bin/env bash

# should be located in /omarchy
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )

MS_DOCS="$HOME/.local/share/Cryptomator/mnt/_docs"

bash $SCRIPT_DIR/setup/apps.sh
bash $SCRIPT_DIR/setup/python-packages.sh

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

echo "Installing Cryptomator"
bash $SCRIPT_DIR/setup/cryptomator.sh
echo "Cryptomator is installed"
echo "Waiting for Cryptomator to be unlocked..."

cryptomator_unlocked="0"
while [[ $cryptomator_unlocked == "0" ]]
do
    sleep 10
    clear
    cryptomator_unlocked="$(ls $MS_DOCS | wc -l)"
    echo "Waiting for Cryptomator to be unlocked..."
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
bash $SCRIPT_DIR/setup/base-symlinks.sh
bash $SCRIPT_DIR/setup/base-cron.sh
bash $SCRIPT_DIR/symlinks/docs.sh
bash $SCRIPT_DIR/setup/vscode.sh
bash $SCRIPT_DIR/setup/onlyoffice.sh
bash $SCRIPT_DIR/setup/flameshot.sh
bash $SCRIPT_DIR/setup/telegram.sh
bash $SCRIPT_DIR/setup/tmux.sh

bash $SCRIPT_DIR/setup/pyvenv.sh x

sudo systemctl restart input-remapper
sudo systemctl enable input-remapper

clear
echo "Linux setup is done! Rebooting to apply settings"
sleep 3
sudo systemctl reboot
