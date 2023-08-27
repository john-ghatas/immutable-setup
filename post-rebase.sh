#!/bin/bash
echo "Setting up packages" 
rpm-ostree install android-tools docker gnome-shell-extension-user-theme neovim tilix zsh

# Enabling the podman services and the TRIM service
systemctl enable --user --now podman.socket
sudo systemctl enable --now fstrim.timer

# Init flatpak
echo "Enabling the Flathub repo..."
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak override --user --filesystem=$HOME/.themes --filesystem=$HOME/.icons --filesystem=$HOME/.config/gtk-4.0

# Add udev rules for adb/fastboot 
curl https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules | sudo tee /etc/udev/rules.d/51-android.rules; sudo chmod +r /etc/udev/rules.d/51-android.rules

echo "Please reboot again to make the changes final" 
