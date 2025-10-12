#!/usr/bin/env bash

if [[ -z $MS_SCR ]]; then
    echo "($(basename $0))" "Env var MS_SCR not defined"
    exit 1
fi

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

# my scripts
rm -rf $HOME/.x
ln -s $MS_SCR $HOME/.x

# cryptomator
rm -rf $HOME/Documents/{_42,_photo,_docs}
ln -s $HOME/.local/share/Cryptomator/mnt/_42 $HOME/Documents/_42
ln -s $HOME/.local/share/Cryptomator/mnt/_photo $HOME/Documents/_photo
ln -s $MS_DOCS $HOME/Documents/_docs


# basic from cloud
rm -rf $HOME/Documents/{syncdata,books,articles,cv,edu}
ln -s $MS_YD_SYNC $HOME/Documents/syncdata
ln -s $HOME/Yandex.Disk/books $HOME/Documents/books
ln -s $HOME/Yandex.Disk/articles $HOME/Documents/articles
ln -s $HOME/Yandex.Disk/cv $HOME/Documents/cv
ln -s $HOME/Yandex.Disk/edu $HOME/Documents/edu


# program data
rm -rf $HOME/.config/input-remapper-2
ln -s $MS_YD_SYNC/input-remapper $HOME/.config/input-remapper-2

# rm -rf $HOME/.config/copyq
# ln -s $MS_YD_SYNC/copyq $HOME/.config/copyq
