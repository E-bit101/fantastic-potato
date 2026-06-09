#!/bin/bash

set -ouex pipefail

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Move files
cp -r system_files/* /

# Enable COPRs
dnf5 -y copr enable yalter/niri 
dnf5 -y copr enable lionheartp/Hyprland

### Install packages
dnf5 install -y fastfetch pipewire wireplumber gvfs

dnf5 install -y fastfetch alacritty thunar
dnf5 install -y thunar-volman thunar-archive-plugin

dnf5 install -y niri quickshell sddm hyprland 

# Disable COPRs so they don't end up enabled on the final image
dnf5 -y copr disable yalter/niri 
dnf5 -y copr disable lionheartp/Hyprland

#### Example for enabling a System Unit File

systemctl enable podman.socket
