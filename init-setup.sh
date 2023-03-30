#!/bin/bash
rpm-ostree update
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Init flatpak
echo "Enabling the Flathub repo..."
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak override --user --filesystem=~/.themes --filesystem=~/.config/gtk-4.0

# Add udev rules for adb/fastboot
sudo runuser -l root -c "curl https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules > /etc/udev/rules.d/51-android.rules; chmod +r /etc/udev/rules.d/51-android.rules"

echo "Please reboot to continue" 
