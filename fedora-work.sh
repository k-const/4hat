#!/bin/bash

## adding repos
echo "fastestmirror=1" >> /etc/dnf/dnf.conf
dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
dnf -y groupupdate core

## installing gnome
dnf -y install @base-x
dnf -y install adwaita-qt5 adwaita-qt6 cabextract code cups-pdf dnfdragora file-roller-nautilus \
firewall-config flatpak gdm gnome-shell gnome-terminal gnome-terminal-nautilus google-noto-cjk-fonts \
google-noto-emoji-color-fonts gutenprint-cups microsoft-edge-stable nautilus nautilus-extensions \
nautilus-search-tool NetworkManager-adsl NetworkManager-l2tp-gnome NetworkManager-ppp \
NetworkManager-pptp-gnome NetworkManager-sstp-gnome NetworkManager-wwan ntfs-3g qgnomeplatform \
qgnomeplatform-qt6 seahorse system-config-printer unifont-fonts usb_modeswitch xorg-x11-font-utils
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf -y groupupdate sound-and-video
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
systemctl set-default graphical.target
plymouth-set-default-theme details -R
