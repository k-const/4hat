#!/bin/bash

## adding repos
echo "fastestmirror=1" >> /etc/dnf/dnf.conf
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
dnf update
dnf -y upgrade
dnf -y groupupdate core

## installing gnome
dnf -y install cabextract cups-pdf dnfdragora file-roller-nautilus firewall-config flatpak gdm gnome-shell \
gnome-terminal gnome-terminal-nautilus gutenprint-cups microsoft-edge-stable nautilus nautilus-extensions \
nautilus-search-tool thunderbird torbrowser-launcher xorg-x11-font-utils
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf -y groupupdate sound-and-video
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.telegram.desktop
systemctl set-default graphical.target
