#!/usr/bin/env bash
set -e

SCRIPT_DIR="$HOME/.local/bin"
mkdir -p "$SCRIPT_DIR"

REPO_INIT_SCRIPT="./distrobox-init.sh"
INI_FILE="./compose.ini"

if [ "$1" == "--nvidia" ]; then
    echo "[ INFO ] NVIDIA flag detected. Switching to NVIDIA configurations."
    INI_FILE="./compose-nvidia.ini"
fi

if [ -f "$REPO_INIT_SCRIPT" ]; then
    cp "$REPO_INIT_SCRIPT" "$SCRIPT_DIR/distrobox-init.sh"
    chmod +x "$SCRIPT_DIR/distrobox-init.sh"
    echo "[ OK ] Init script copied to $SCRIPT_DIR"
else
    echo "[ ERR ] Could not find $REPO_INIT_SCRIPT! Are you in the repo root?"
    exit 1
fi

if [ ! -f "$INI_FILE" ]; then
    echo "[ ERR ] Target configuration file $INI_FILE not found in the current directory!"
    exit 1
fi

echo "Starting local Distrobox assemble using $INI_FILE..."
distrobox assemble create --file "$INI_FILE" --replace

echo "[ SUCCESS ] Your boxes are fully assembled and online!"

