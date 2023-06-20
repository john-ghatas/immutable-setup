# A collection of podman images to rebuild containers quickly
Contains various purpose images for containers, to build them run the commands listed below. 

# Build the images and create them with the legacy method
```
podman build -f Containerfile.development -t development-base
podman build -f Containerfile.rstudio -t rstudio-base
podman build -f Containerfile.general -t general-base
podman build -f Containerfile.ubuntu -t ubuntu-base

distrobox create -i localhost/development-base -n development
distrobox create -i localhost/general-base -n general
distrobox create -i localhost/rstudio-base -n rstudio
distrobox create -i localhost/ubuntu-base -n ubuntu
```

# Build for use with the .ini
```
podman build -f Containerfile.development -t development-base
podman build -f Containerfile.rstudio -t rstudio-base
podman build -f Containerfile.general -t general-base
podman build -f Containerfile.ubuntu -t ubuntu-base
```

# Compose, and update/remove the containers with the .ini file
Use the compose-nvidia.ini file if you have an NVIDIA GPU 

```
# Create
distrobox-assemble create -f ./compose.ini

# Update
distrobox-assemble create --replace -f ./compose.ini

# Destroy
distrobox-assemble rm -f ./compose.ini
```

# Steps after creating the image and creating the distroboxes
Export the apps and or binaries
```
# GUI Applications
distrobox-export --app codium --extra-flags "--foreground"
distrobox-export --app libreoffice
distrobox-export --app thunderbird --extra-flags "--foreground"

# Services
distrobox-export --service syncthing --extra-flags "--allow-newer-config"

# Binaries
distrobox-export --bin /usr/bin/vim -export-path ~/.local/bin

# If an app/binary needs sudo rights in the container just add --sudo
distrobox-export --app rstudio --extra-flags "--foreground" --sudo
```
