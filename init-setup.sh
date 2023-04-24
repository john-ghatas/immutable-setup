#!/bin/bash
rpm-ostree update
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Init flatpak
echo "Enabling the Flathub repo..."
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak override --user --filesystem=$HOME/.themes --filesystem=$HOME/.icons --filesystem=$HOME/.config/gtk-4.0

# Add udev rules for adb/fastboot and misc stuff grabbed from the uBlue repo
sudo runuser -l root -c "curl https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules > /etc/udev/rules.d/51-android.rules; chmod +r /etc/udev/rules.d/51-android.rules"
sudo runuser -l root -c "curl https://raw.githubusercontent.com/ublue-os/config/main/files/etc/udev/rules.d/60-openrgb.rules > /etc/udev/rules.d/60-openrgb.rules; chmod +r /etc/udev/rules.d/60-openrgb.rules"
sudo runuser -l root -c "curl https://raw.githubusercontent.com/ublue-os/config/main/files/etc/udev/rules.d/80-wooting.rules > /etc/udev/rules.d/80-wooting.rules; chmod +r /etc/udev/rules.d/80-wooting.rules"

# Add the user to the plugdev group
CURRENT_USER=$USER
sudo groupadd plugdev
sudo usermod -aG plugdev $CURRENT_USER

echo "Added $CURRENT_USER to the group plugdev to activate the udev rules"
sudo id -nG $CURRENT_USER

echo "Please reboot to continue" 
