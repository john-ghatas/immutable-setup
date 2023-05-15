#!/bin/bash
rpm-ostree kargs \
    --append=rd.driver.blacklist=nouveau \
    --append=modprobe.blacklist=nouveau \
    --append=nvidia-drm.modeset=1
sudo systemctl enable --now supergfxd

echo "If you want secure boot to work head to https://ublue.it/images/nvidia/ and follow the steps to create the layered certificate. Enroll the MOK cert in the first reboot attempt after creating the key."
