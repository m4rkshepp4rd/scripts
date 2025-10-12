#!/usr/bin/env bash

rm -rf $HOME/Music

if [[ -z $1 ]]; then 
    ln -s $HOME/Yandex.Disk/music $HOME/Music  
fi
