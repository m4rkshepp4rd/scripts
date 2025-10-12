#!/usr/bin/env bash

rm -rf $HOME/Videos


if [[ -z $1 ]]; then 
    ln -s $HOME/Yandex.Disk/videos $HOME/Videos  
fi
