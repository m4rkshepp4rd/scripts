#!/usr/bin/env bash


# Install apps
sudo pacman -Sy --needed base-devel llvm llvm-libs

bin_path="$(which paru)"
if [[ -z $bin_path ]]; then
    paru_path="$HOME/paru" 
    git clone https://aur.archlinux.org/paru.git $paru_path
    cd $paru_path
    makepkg -si
    cd
fi

paru -Rns $(paru -Qq firefox lollypop manjaro-hello kvantum-manjaro manjaro-hello gnome-logs\
 gnome-weather gnome-user-docs gnome-tour gnome-calendar kvantum-qt5 gnome-console decibels malcontent\
 gnome-text-editor gnome-clocks totem manjaro-application-utility\
)
paru -Syu --needed\
 braus-git brave-browser chromium yandex-disk telegram-desktop qbittorrent\
 amneziavpn-bin\
 vlc obs-studio flameshot wl-clipboard\
 onlyoffice-desktopeditors drawio-desktop\
 gnome-terminal visual-studio-code-insiders-bin\
 steam samrewritten-git input-remapper-git\
 git tmux jq fzf rich-cli typescript make\
 gvfs-mtp\
 copyq\
 ttf-font-awesome noto-fonts-emoji ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-meslo-nerd
