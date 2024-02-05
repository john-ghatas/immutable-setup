#!/usr/bin/env bash
# ADW GTK3 Variables
ADW_GTK_VERSION=$(curl -Ls https://github.com/lassekongo83/adw-gtk3/releases/latest | grep -E -o "app-argument=.*\"" | grep -o "https.*" | sed 's/"//g' | cut -d "/" -f 8)
ADW_GTK_FILENAME=$(echo $ADW_GTK_VERSION | sed "s/\./-/g")

echo "Pre-caching sudo session"
sudo echo "Session authorized"
read -p "Enter the desired hostname: " NEW_HOSTNAME

echo -e "-------------------\nSTARTING INIT SETUP\n-------------------"
# Installing packages
echo "Install packages of the host system"
sudo transactional-update -n --quiet pkg install docker docker-compose zsh neovim gnome-tweaks tilix git android-tools dirmngr bind-utils

echo "Adding rights for docker to the current user"
sudo usermod -aG docker $USER

echo "Installing udev rules"
curl -s https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules | sudo tee /etc/udev/rules.d/51-android.rules > /dev/null
echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"' | sudo tee /etc/udev/rules.d/92-viia.rules > /dev/null
sudo chmod +r /etc/udev/rules.d/*.rules

echo "Installing and setting the ADW-GTK3 theme as the default GTK theme"
# Install the ADW-GTK3 theme
mkdir -p ~/.themes; wget -q https://github.com/lassekongo83/adw-gtk3/releases/download/$ADW_GTK_VERSION/adw-gtk3$ADW_GTK_FILENAME.tar.xz
tar -xvf adw-gtk3*tar.xz -C ~/.themes > /dev/null
rm adw-gtk3*tar.xz

# Flatpak install and set the dark theme as the default GTK theme
flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

echo "Enable fractional scaling"
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']" # Wayland
gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']" # X11

echo "Starting background configuration"
systemctl enable --user --now podman.socket
sudo systemctl enable --now fstrim.timer
sudo systemctl enable --now docker
sudo mkdir -p /etc/systemd/system/transactional-update.timer.d; echo -e "[Timer]\nRandomizedDelaySec=8m" | sudo tee /etc/systemd/system/transactional-update.timer.d/override.conf > /dev/null
gpg-agent --daemon > /dev/null 2>/dev/null

echo "Setting the hostname of this machine to $NEW_HOSTNAME"
sudo hostnamectl set-hostname $NEW_HOSTNAME

echo "-----------------------------------------------------------------"
echo "Please reboot and run 'opi codecs' to install third party codecs"
echo "-----------------------------------------------------------------"
