#!/bin/bash
source /etc/os-release

read -p "What version of Fedora are you upgrading to? (37, 38 etc): " NEXT_VERSION
echo "Upgrading to Fedora $NEXT_VERSION from Fedora $VERSION_ID"
read -p "Press any key to continue...." 

sudo rpm-ostree rebase fedora:fedora/$NEXT_VERSION/x86_64/$VARIANT_ID \
  --uninstall=rpmfusion-free-release-$VERSION_ID-1.noarch \
  --uninstall=rpmfusion-nonfree-release-$VERSION_ID-1.noarch \
  --install=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$NEXT_VERSION.noarch.rpm \
  --install=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$NEXT_VERSION.noarch.rpm
