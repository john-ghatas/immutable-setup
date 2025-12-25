#!/bin/bash
echo "Setting up packages" 
rpm-ostree install gnupg2-smime libnfc libnfc-examples neovim tilix

# Add udev rules for hardware keys
sudo wget https://raw.githubusercontent.com/Yubico/libfido2/refs/heads/main/udev/70-u2f.rules -O /etc/udev/rules.d/70-u2f.rules && sudo chmod 774 /etc/udev/rules.d/70-u2f.rules

# Ensure the FSTrim is enabled and auto updates are running frequently
sudo systemctl enable --now fstrim.timer
sudo systemctl enable --now rpm-ostreed-automatic

# Init flatpak
echo "Enabling needed overrides for Flatpak Theming"
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak override --user --filesystem=$HOME/.themes --filesystem=$HOME/.icons --filesystem=$HOME/.config/gtk-4.0

# Init GPG and PCSCd
systemctl --user enable --now  gpg-agent.socket gpg-agent-extra.socket  gpg-agent-ssh.socket
sudo systemctl enable --now pcscd.service pcscd.socket

# Install DevBox
curl -L -o ~/.local/bin/devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && chmod 755 ~/.local/bin/devpod

# Setup CoW-free directories
for d in /var/log /var/cache /var/lib/docker /var/lib/containers/storage /var/lib/flatpak; do
  [ -d "$d" ] && sudo chattr +C "$d"
done

sudo find /var/home -type d -exec chattr +C {} + # Home specific CoW flags

# Add udev rules for adb/fastboot and usevia.app 
curl https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules | sudo tee /etc/udev/rules.d/51-android.rules; sudo chmod +r /etc/udev/rules.d/51-android.rules

echo "Please reboot again to make the changes final" 
