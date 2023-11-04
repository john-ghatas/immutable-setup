#!/usr/bin/env bash
# This file is made to use with docker only, for the podman 
# commands please go to the README.md

# General container build
docker buildx build -t johngh/distrobox-images:general-base -f Containerfile.general --platform linux/amd64 --push .

# Ubuntu container build
docker buildx build -t johngh/distrobox-images:ubuntu-base -f Containerfile.ubuntu --platform linux/amd64 --push .

# Rstudio container build
docker buildx build -t johngh/distrobox-images:rstudio-base -f Containerfile.rstudio --platform linux/amd64 --push .

# Development container build
docker buildx build -t johngh/distrobox-images:development-base -f Containerfile.development --platform linux/amd64 --push .
