#!/bin/bash
sudo systemctl enable --now supergfxd

just set-kargs-nvidia

echo "If you want secure boot to work head to https://ublue.it/images/nvidia/ and follow the steps to create the layered certificate. Enroll the MOK cert in the first reboot attempt after creating the key."
