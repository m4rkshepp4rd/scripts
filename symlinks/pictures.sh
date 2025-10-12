#!/usr/bin/env bash

rm -rf $HOME/Pictures

if [[ -z $1 ]]; then 
    ln -s $HOME/Yandex.Disk/pictures $HOME/Pictures  
fi
