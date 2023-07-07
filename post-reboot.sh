#!/bin/bash
echo "Setting up packages" 
rpm-ostree install android-tools docker gnome-shell-extension-user-theme neovim tilix zsh

# Enabling the podman services and the TRIM service
systemctl enable --user --now podman.socket
sudo systemctl enable --now fstrim.timer

echo "Please reboot again to make the changes final" 
