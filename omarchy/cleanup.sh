#!/usr/bin/env bash

paru -Rns $(paru -Qq 1password-beta 1password-cli aether\
 lazydocker lazygit libreoffice-fresh obsidian\
 xournalpp typora signal-desktop spotify\
)
 #pinta mpv\)

remove-app() {
    rm "$HOME/.local/share/applications/$1.desktop"
    rm "$HOME/.local/share/applications/icons/$1.png"
}

remove-app "Basecamp"
remove-app "ChatGPT"
remove-app "Discord"
remove-app "Docker"
remove-app "Figma"
remove-app "GitHub"
remove-app "Google Contacts"
remove-app "Google Messages"
remove-app "Google Photos"
remove-app "HEY"
remove-app "WhatsApp"
remove-app "X"
remove-app "YouTube"
remove-app "Zoom"
