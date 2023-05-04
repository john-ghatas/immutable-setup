#!/bin/bash
rpm-ostree kargs \
    --append=rd.driver.blacklist=nouveau \
    --append=modprobe.blacklist=nouveau \
    --append=nvidia-drm.modeset=1

echo "If you want secure boot to work head to https://ublue.it/images/nvidia/ and follow the steps to import the layered certificate."
