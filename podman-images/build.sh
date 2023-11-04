#!/usr/bin/env bash
# This file is made to use with docker only, for the podman 
# commands please go to the README.md

# Prune the system before starting the build and enable buildx
echo "y" | docker system prune -a --volumes 
docker buildx create --use

# General container build
docker buildx build -t johngh/distrobox-images:general-base  --platform linux/amd64,linux/arm64 --push - < Containerfile.general

# Ubuntu container build
docker buildx build -t johngh/distrobox-images:ubuntu-base  --platform linux/amd64,linux/arm64 --push - < Containerfile.ubuntu

# Rstudio container build
docker buildx build -t johngh/distrobox-images:rstudio-base  --platform linux/amd64,linux/arm64 --push - < Containerfile.rstudio

# Development container build
docker buildx build -t johngh/distrobox-images:development-base  --platform linux/amd64,linux/arm64 --push - < Containerfile.development
