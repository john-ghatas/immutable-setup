#!/bin/bash
# Installation script for Lenovo Yoga 14ITL5 Touchpad Fix
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

# Setup thermald and tuned
echo "Setup thermald and tuned"

sudo mkdir -p /etc/systemd/system/thermald.service.d
sudo echo -e "[Service]\nExecStart=\nExecStart=/usr/sbin/thermald --no-daemon --dbus-enable --ignore-cpuid-check --exclusive-control" | sudo tee /etc/systemd/system/thermald.service.d/override.conf && sudo systemctl daemon-reload

sudo mkdir -p /etc/thermald
sudo echo -e '<?xml version="1.0"?><ThermalConfiguration></ThermalConfiguration>' | sudo tee /etc/thermald/thermal-conf.xml

sudo systemctl daemon-reload
sudo systemctl restart thermald.service

sudo systemctl enable --now powertop.service
sudo systemctl enable --now tuned

sudo mkdir -p /etc/tuned
sudo tee /etc/tuned/tuned-main.conf > /dev/null << 'EOF'
daemon = 1
dynamic_tuning = 1
sleep_interval = 1
update_interval = 1
EOF

# Create directories
sudo mkdir -p /etc/tuned/profiles/{thinkpad-battery,thinkpad-powersave}
sudo mkdir -p /etc/systemd/system-sleep

# Copy the profiles
sudo cp tuned/tuned-balanced.conf /etc/tuned/profiles/thinkpad-battery/tuned.conf
sudo cp tuned/tuned-powersave.conf /etc/tuned/profiles/thinkpad-powersave/tuned.conf
sudo cp tuned/ppd.conf /etc/tuned/ppd.conf

# Install the sleep scripts
sudo cp tuned/tuned-wake-fix /etc/systemd/system-sleep/tuned-wake-fix
sudo chmod +x /etc/systemd/system-sleep/tuned-wake-fix
sudo cp tuned/tuned-wake-fix.service /etc/systemd/system/tuned-wake-fix.service

sudo systemctl daemon-reload
sudo systemctl enable tuned-wake-fix.service
sudo systemctl restart tuned

# Setting up thinkfan
echo "Setting up the custom fan curve for thinkfan - geared towards PTM7950"
rpm-ostree install thinkfan
sudo cp thinkfan.yaml /etc/thinkfan.yaml

# Add misc audio tweaks
echo "Setting up Dolby Atmos"
mkdir -p ~/.config/pipewire/pipewire.conf.d
cp 99-dolby-atmos-default.conf ~/.config/pipewire/pipewire.conf.d/99-dolby-atmos-default.conf

echo "Installation complete. Please reboot."
