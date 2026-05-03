#!/bin/bash

set -ouex pipefail

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
