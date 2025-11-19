#!/usr/bin/env bash

# should be run from root dir
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

dconf_terminal_path="/org/gnome/terminal/legacy/profiles:"
auto_name="my-linux-setup.desktop"
auto_logout_tmp="/tmp/$auto_name"

linux_setup_uuid="09748d28-2d63-4294-9439-0ae1718afde1"
base_profile_uuid="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"

MS_DOCS="$HOME/Documents/docs"

if [[ -z $1 ]]; then
    bash $SCRIPT_DIR/gnome/settings.sh
    echo "GNOME settings are set"

    sleep 2
    clear
    echo "Installing apps and GNOME extensions..."
    bash $SCRIPT_DIR/setup/apps.sh
    # Will be gone, need to be switched to alacritty
    paru -S gnome-terminal
    bash $SCRIPT_DIR/gnome/autostart.sh
    bash $SCRIPT_DIR/gnome/extensions.sh
    echo "Apps and GNOME extensions are installed"

    sleep 2
    clear
    echo "Yandex.Disk setup..."
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    bash $SCRIPT_DIR/setup/yandex-disk.sh
    echo "Yandex.Disk has been set up"
    echo "Waiting for files to download..."
    yd_status=""
    while [[ $yd_status != "idle" ]]
    do
        sleep 30
        clear
        ydtmp=$(yandex-disk status | grep status:)
        yd_status=${ydtmp##* }
        echo "Sync status: $yd_status"
        echo "$(yandex-disk status | head -n 1)"
        echo "Waiting for files to download..."
    done
    echo "Files have been downloaded. Logging out..."
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
    sleep 3
    
    # create autostart hook
    dconf write "$dconf_terminal_path/list" "['$base_profile_uuid','$linux_setup_uuid']"
    dconf write "$dconf_terminal_path/default" "'$base_profile_uuid'"
    dconf write "$dconf_terminal_path/:$base_profile_uuid/visible-name" "'base-profile'"
    dconf write "$dconf_terminal_path/:$linux_setup_uuid/visible-name" "'linux-setup'"
    dconf write "$dconf_terminal_path/:$linux_setup_uuid/use-custom-command" "true"
    dconf write "$dconf_terminal_path/:$linux_setup_uuid/custom-command" "'bash -i $SCRIPT_DIR/gnome/main.sh 1'"

    echo "[Desktop Entry]" > $auto_logout_tmp
    echo "Exec=gnome-terminal --window-with-profile=linux-setup" >> $auto_logout_tmp
    echo "Type=Application" >> $auto_logout_tmp
    echo "Name=my-linux-setup" >> $auto_logout_tmp
    echo "Terminal=false" >> $auto_logout_tmp
    sudo rm $HOME/.config/autostart/$auto_name
    cp $auto_logout_tmp $HOME/.config/autostart/$auto_name
    rm $auto_logout_tmp

    gnome-session-quit
else
    if [[ $1 == "1" ]]; then
        echo "Resuming after logout"
        bash $SCRIPT_DIR/gnome/extensions-setup.sh
        echo "Extensions are set up"

        dconf write "$dconf_terminal_path/:$linux_setup_uuid/use-custom-command" "true"
        dconf write "$dconf_terminal_path/:$linux_setup_uuid/custom-command" "'bash -i $SCRIPT_DIR/gnome/main.sh 2'"
        echo "Rebooting"
        sleep 3
        sudo systemctl reboot
    elif [[ $1 == "2" ]]; then
        echo "Resuming after reboot"

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
        
        # Make sure everything up to this point does not use vars defined in this
        source $MS_DOCS/configs/env/.shared_env
        bash $SCRIPT_DIR/bin.sh

        # Run custom scripts that use my env vars
        dconf write "$dconf_terminal_path/:$linux_setup_uuid/use-custom-command" "false"
        sudo rm $HOME/.config/autostart/$auto_name

        bash $SCRIPT_DIR/gnome/shortcuts.sh
        
        bash $SCRIPT_DIR/setup/env.sh
        bash $SCRIPT_DIR/setup/zsh.sh -f
        bash $SCRIPT_DIR/setup/bash.sh

        bash $SCRIPT_DIR/index.sh
        bash $SCRIPT_DIR/symlinks/base.sh
        bash $SCRIPT_DIR/symlinks/x.sh -l
        bash $SCRIPT_DIR/setup/cron.sh
        # bash $SCRIPT_DIR/symlinks/docs.sh
        bash $SCRIPT_DIR/setup/vscode.sh
        bash $SCRIPT_DIR/setup/pop-shell.sh
        bash $SCRIPT_DIR/setup/onlyoffice.sh
        bash $SCRIPT_DIR/setup/flameshot.sh
        bash $SCRIPT_DIR/setup/telegram.sh
        bash $SCRIPT_DIR/setup/tmux.sh
        bash $SCRIPT_DIR/setup/alacritty.sh
        bash $SCRIPT_DIR/setup/swayosd.sh

        bash $SCRIPT_DIR/gnome/settings.sh

        bash $SCRIPT_DIR/setup/pyvenv.sh -p x
                
        sudo systemctl restart input-remapper
        sudo systemctl enable input-remapper

        bash $SCRIPT_DIR/gnome/cleanup.sh

        clear
        echo "Linux setup is done! Rebooting to apply settings"
        sleep 3
        sudo systemctl reboot
    else
        echo "Wrong argument"
    fi
fi
