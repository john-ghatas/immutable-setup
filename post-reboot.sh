#!/bin/bash
echo "Setting up packages" 
rpm-ostree install android-tools docker gnome-shell-extension-user-theme neovim tilix zsh

# Install repo version of distrobox 
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

echo "Please reboot again to make the changes final" 
