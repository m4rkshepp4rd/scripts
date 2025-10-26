#!/usr/bin/env bash


# Install apps
sudo pacman -Syu --needed base-devel llvm llvm-libs

if ! command -v "paru" &> /dev/null; then
    paru_path="$HOME/paru" 
    git clone https://aur.archlinux.org/paru.git $paru_path
    cd $paru_path
    makepkg -si
    cd -
fi

paru -Syu --needed\
 braus-git brave-browser yandex-disk telegram-desktop qbittorrent\
 cryptomator-cli\
 amneziavpn-bin\
 gnome-calculator\
 alacritty\
 zsh\
 vlc obs-studio flameshot wl-clipboard\
 onlyoffice-bin drawio-desktop\
 visual-studio-code-insiders-bin\
 steam samrewritten-git input-remapper-git\
 git tmux jq fzf rich-cli typescript make\
 gvfs-mtp\
 copyq\
 cronie\
 ttf-font-awesome noto-fonts-emoji ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-meslo-nerd
