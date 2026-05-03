#!/bin/bash

set -ouex pipefail

echo "Installing base operating system software..."

# Copy /ctx/system_files into /
pacman -S --noconfirm \
    rsync

rsync -rvK /ctx/system_files/ /

# Activate the rechunker group fix
chmod +x /usr/bin/rechunker-group-fix
systemctl enable rechunker-group-fix.service

# Downgrade the kernel to 6.19.14 (see issue: https://github.com/bootc-dev/bootc/issues/2174)
# TODO: remove this as soon as the issue is fixed
pacman -Rsn --noconfirm linux
rm -rfv /usr/lib/modules
curl -o linux-6.19.14.arch1-1-x86_64.pkg.tar.zst https://archive.archlinux.org/packages/l/linux/linux-6.19.14.arch1-1-x86_64.pkg.tar.zst
pacman -U --noconfirm linux-6.19.14.arch1-1-x86_64.pkg.tar.zst

# Install drivers
pacman -S --noconfirm \
    mesa \
    vulkan-radeon \
    vulkan-intel \
    dmidecode \
    amd-ucode \
    intel-ucode \
    thermald

# Install core operating system software
pacman -S --noconfirm \
    networkmanager \
    sudo \
    power-profiles-daemon \
    powertop \
    gamemode \
    fprintd \
    usbutils \
    bluez \
    bluez-utils \
    cups \
    cups-pdf \
    unrar \
    unzip \
    tar \
    man-db

# Install fonts
pacman -S --noconfirm \
    noto-fonts \
    noto-fonts-emoji \
    noto-fonts-extra \
    noto-fonts-cjk \
    ttf-dejavu \
    ttf-liberation \

# Install spice-vdagent
pacman -S --noconfirm spice-vdagent

# Install Hec's bootc repo for uupd
pacman-key --init
pacman-key --recv-key 5DE6BF3EBC86402E7A5C5D241FA48C960F9604CB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 5DE6BF3EBC86402E7A5C5D241FA48C960F9604CB

tee -a /etc/pacman.conf <<EOL
[bootc]
SigLevel = Required
Server = https://github.com/hecknt/arch-bootc-pkgs/releases/download/\$repo
EOL

pacman -Sy
pacman -S --noconfirm bootc/uupd bootc/bootupd

# Install ufw
pacman -S --noconfirm ufw
