# A collection of podman images to rebuild containers quickly
Contains various purpose images for containers, to build them run the commands listed below. 

# Important notes
Building the images is not necessary, **if you are capped on bandwidth it is highly recommended to build the images locally and use the .local compose files. The images grabbed will eat up around 8.8GB bandwidth**.

When using the Docker Hub hosted images you can head directly to [assembling the distroboxes](#compose-and-updateremove-the-containers-with-the-ini-file).

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

Use the compose-nvidia.ini file if you have an NVIDIA GPU. If your are using locally built images use the .local versions of the compose files.

```
# Create
distrobox-assemble create --file ./compose.ini

# Update
distrobox-assemble create --file ./compose.ini --replace

# Destroy
distrobox-assemble rm --file ./compose.ini
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
