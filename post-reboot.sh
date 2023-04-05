#!/bin/bash
echo "Setting up packages" 
rpm-ostree install distrobox docker ffmpeg gnome-tweaks gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi neovim tilix zsh 
rpm-ostree override remove mesa-va-drivers --install mesa-va-drivers-freeworld
rpm-ostree update --uninstall rpmfusion-free-release --uninstall rpmfusion-nonfree-release --install rpmfusion-free-release --install rpmfusion-nonfree-release

echo "Install the hardware codecs for your system"
echo "AMD: rpm-ostree override remove mesa-vdpau-drivers --install mesa-vdpau-drivers-freeworld"
echo "Intel: rpm-ostree install intel-media-driver"

echo "Please reboot again to make the changes final" 
