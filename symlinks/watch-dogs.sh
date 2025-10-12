#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf "$HOME/.local/share/Steam/steamapps/compatdata/243470/pfx/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/savegames/2deb4b89-804b-445a-bb2d-d7022a822744/541"

if [[ -z $1 ]]; then 
    mkdir -p "$HOME/.local/share/Steam/steamapps/compatdata/243470/pfx/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/savegames/2deb4b89-804b-445a-bb2d-d7022a822744"
    ln -s $MS_YD_SYNC/watch-dogs "$HOME/.local/share/Steam/steamapps/compatdata/243470/pfx/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/savegames/2deb4b89-804b-445a-bb2d-d7022a822744/541"
fi
