#!/usr/bin/env bash

paru -Sy --needed --noconfirm mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

# radeon-profile
paru -Sy --needed --noconfirm  radeon-profile-git radeon-profile-daemon-git
systemctl enable radeon-profile-daemon.service
systemctl restart radeon-profile-daemon.service
cp /usr/share/applications/radeon-profile.desktop $HOME/.config/autostart
