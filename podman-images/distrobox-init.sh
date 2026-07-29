#!/bin/bash
mkdir -p /usr/local/bin
BINARIES=(devpod docker flatpak podman distrobox gnome-shell)
for b in "${BINARIES[@]}"; do
    ln -sf /usr/bin/distrobox-host-exec "/usr/local/bin/${b}"
done
