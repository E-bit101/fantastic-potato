#!/bin/bash

set -ouex pipefail

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Move files
cp -r /ctx/system_files/. /

# Enable COPRs
dnf5 -y copr enable yalter/niri 
dnf5 -y copr enable lionheartp/Hyprland

### Install packages
# Core
dnf5 install -y pipewire wireplumber gvfs xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring
dnf5 install -y qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia qt6-qtimageformats

# Apps
dnf5 install -y fastfetch alacritty nemo steam

# System utilities
dnf5 install -y niri quickshell sddm hyprland hyprpaper hyprpolkitagent hyprland-guiutils 


# Disable COPRs so they don't end up enabled on the final image
dnf5 -y copr disable yalter/niri 
dnf5 -y copr disable lionheartp/Hyprland

systemctl enable config-manager.service
