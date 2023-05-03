#!/bin/bash

# Init flatpak
echo "Enabling the Flathub repo..."
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak override --user --filesystem=$HOME/.themes --filesystem=$HOME/.icons --filesystem=$HOME/.config/gtk-4.0

# Add udev rules for adb/fastboot 
curl https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules | sudo tee /etc/udev/rules.d/51-android.rules; chmod +r /etc/udev/rules.d/51-android.rules

echo "Please rebase to a ublue image ublue.it/images/ (pick either silverblue-main or silverblue-nvidia) based on the dedicated gpu you have."
echo "If you need more information on the other spins visit the ublue.it website."
