#!/bin/bash
echo "Setting up packages" 
rpm-ostree install android-tools gnome-shell-extension-user-theme neovim tilix zsh

# Enabling the podman services and the TRIM service, ensure auto updates
systemctl enable --user --now podman.socket
sudo systemctl enable --now fstrim.timer
sudo systemctl enable --now rpm-ostreed-automatic

# Init flatpak
echo "Enabling needed overrides for Flatpak Theming"
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak override --user --filesystem=$HOME/.themes --filesystem=$HOME/.icons --filesystem=$HOME/.config/gtk-4.0

# Init GPG
systemctl --user enable --now  gpg-agent.socket gpg-agent-extra.socket  gpg-agent-ssh.socket

# Add udev rules for adb/fastboot and usevia.app 
curl https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules | sudo tee /etc/udev/rules.d/51-android.rules; sudo chmod +r /etc/udev/rules.d/51-android.rules
echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"' | sudo tee /etc/udev/rules.d/92-viia.rules

echo "Please reboot again to make the changes final" 
