#!/bin/bash
# Installation script for Lenovo Yoga 14ITL5 Touchpad Fix
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

# Disable thermald and enabled tuned
echo "Disable thermald and enabled tuned"
sudo systemctl disable --now thermald
sudo systemctl enable --now tuned

sudo mkdir -p /etc/tuned
sudo tee /etc/tuned/tuned-main.conf > /dev/null << 'EOF'
daemon = 1
dynamic_tuning = 1
sleep_interval = 1
update_interval = 10
EOF

sudo mkdir -p /etc/tuned/balanced-battery
sudo tee /etc/tuned/balanced-battery/tuned.conf > /dev/null << 'EOF'
[main]
summary=Optimized balanced battery profile for ThinkPad T14 Gen 4 (i5-1335U)
include=balanced-battery

[cpu]
governor=powersave
energy_perf_bias=balance_power
energy_performance_preference=balance_power

[audio]
timeout=10

[sysctl]
kernel.nmi_watchdog=0
vm.laptop_mode=3
EOF

sudo systemctl restart tuned

# Setting up thinkfan
echo "Setting up the custom fan curve for thinkfan - geared towards PTM7950"
rpm-ostree install thinkfan
sudo cp thinkfan.yaml /etc/thinkfan.yaml

# Add misc audio tweaks
echo "Setting up Dolby Atmos"
mkdir ~/.config/pipewire/pipewire.conf.d
cp 99-dolby-atmos-default.conf ~/.config/pipewire/pipewire.conf.d/99-dolby-atmos-default.conf

echo "Installation complete. Please reboot."
