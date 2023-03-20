#!/bin/bash
source /etc/os-release

read -p "What version of Fedora are you upgrading to? (37, 38 etc): " NEXT_VERSION
echo "Upgrading to Fedora $NEXT_VERSION from Fedora $VERSION_ID"
read -p "Press any key to continue...." 

sudo rpm-ostree rebase fedora:fedora/$NEXT_VERSION/x86_64/$VARIANT_ID 
