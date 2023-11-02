#!/usr/bin/env bash
# This file is made to use with docker only, for the podman 
# commands please go to the README.md

# Prune the system before starting the build
echo "y" | docker system prune -a --volumes 

# General container build
docker build -t general-base - < Containerfile.general

# Ubuntu container build
docker build -t ubuntu-base - < Containerfile.ubuntu

# Rstudio container build
docker build -t rstudio-base - < Containerfile.rstudio

# Development container build
docker build -t development-base - < Containerfile.development 

# Tag the images
docker tag general-base johngh/distrobox-images:general-base
docker tag ubuntu-base johngh/distrobox-images:ubuntu-base
docker tag rstudio-base johngh/distrobox-images:rstudio-base
docker tag development-base johngh/distrobox-images:development-base

# Push the images
docker push johngh/distrobox-images:rstudio-base
docker push johngh/distrobox-images:ubuntu-base
docker push johngh/distrobox-images:general-base
docker push johngh/distrobox-images:development-base
