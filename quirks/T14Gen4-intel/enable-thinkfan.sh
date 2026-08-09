#!/bin/bash
# Installation script for Lenovo Yoga 14ITL5 Touchpad Fix
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

# Install the required packages
rpm-ostree install thinkfan 
rpm-ostree override remove tuned-ppd tuned --install power-profiles-daemon

# Setup power management
echo "Setup power management"
sudo systemctl disable --now tuned tuned-ppd thermald
sudo systemctl enable --now powertop


# Setting up thinkfan
echo "Setting up the custom fan curve for thinkfan - geared towards PTM7950"
sudo cp thinkfan.yaml /etc/thinkfan.yaml
sudo mkdir -p /etc/systemd/system/thinkfan.service.d
echo -e "[Service]\nExecStart=\nExecStart=/usr/sbin/thinkfan -n -q -b 0 -s 5" | sudo tee /etc/systemd/system/thinkfan.service.d/override.conf
sudo systemctl daemon-reload

# Add misc audio tweaks
echo "Setting up Dolby Atmos"
mkdir -p ~/.config/pipewire/pipewire.conf.d
cp 99-dolby-atmos-default.conf ~/.config/pipewire/pipewire.conf.d/99-dolby-atmos-default.conf

echo "Installation complete. Please reboot."
