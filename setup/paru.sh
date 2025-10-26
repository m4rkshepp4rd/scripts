#!/usr/bin/env bash

if ! command -v "paru" &> /dev/null; then
    paru_path="$HOME/paru" 
    git clone https://aur.archlinux.org/paru.git $paru_path
    cd $paru_path
    makepkg -si
    cd -
fi
