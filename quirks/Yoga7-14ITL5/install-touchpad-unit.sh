#!/bin/bash
# Installation script for Lenovo Yoga 14ITL5 Touchpad Fix
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

SERVICE_FILE="touchpad-resume-fix.service"
POLKIT_FILE="10-touchpad-reset.rules"
POLKIT_DEST="/etc/polkit-1/rules.d"

# Verify source files
for file in "$SERVICE_FILE" "$POLKIT_FILE"; do
    if [ ! -f "$file" ]; then
        echo "Error: Source file $file not found."
        exit 1
    fi
done

echo "Starting touchpad configuration installation..."

# Install SystemD unit
sudo cp "$SERVICE_FILE" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_FILE"

# Install Polkit rules
if [ ! -d "$POLKIT_DEST" ]; then
    sudo mkdir -p "$POLKIT_DEST"
fi
sudo cp "$POLKIT_FILE" "$POLKIT_DEST/"

echo "Installation complete. System configured successfully."
