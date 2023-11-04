#!/usr/bin/env bash
# This file is made to use with docker only, for the podman 
# commands please go to the README.md

# General container build
docker buildx build -t johngh/distrobox-images:general-base:arm -f Containerfile.general --platform linux/arm64 --push .

# Ubuntu container build
docker buildx build -t johngh/distrobox-images:ubuntu-base:arm -f Containerfile.ubuntu --platform linux/arm64 --push .

# Rstudio container build
docker buildx build -t johngh/distrobox-images:rstudio-base:arm -f Containerfile.rstudio --platform linux/arm64 --push .

# Development container build
docker buildx build -t johngh/distrobox-images:development-base:arm -f Containerfile.development --platform linux/arm64 --push .
