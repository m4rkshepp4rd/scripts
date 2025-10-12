#!/usr/bin/env bash

if [[ -z $MS_YD_SYNC ]]; then
    echo "($(basename $0))" "Env var MS_YD_SYNC not defined"
    exit 1
fi

rm -rf $HOME/Documents/syncdata
rm -rf $HOME/Documents/books
rm -rf $HOME/Documents/articles
rm -rf $HOME/Documents/cv
rm -rf $HOME/Documents/edu


if [[ -z $1 ]]; then 
    ln -s $MS_YD_SYNC $HOME/Documents/syncdata
    ln -s $HOME/Yandex.Disk/books $HOME/Documents/books
    ln -s $HOME/Yandex.Disk/articles $HOME/Documents/articles
    ln -s $HOME/Yandex.Disk/cv $HOME/Documents/cv
    ln -s $HOME/Yandex.Disk/edu $HOME/Documents/edu
fi
