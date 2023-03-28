# A collection of podman images to rebuild containers quickly
Contains various purpose images for containers, to build them run the commands listed below. Change the 

```
podman build -f <file> -t <image_name>
distrobox create -i localhost/<image_name> -n <distrobox_name>
```

# Examples
```
podman build -f Containerfile.development -t fedora-dev-38
distrobox create -i localhost/fedora-dev-38 -n fedora-development
```

# Steps after creating the image and creating the distroboxes
Export the apps and or binaries
```
# GUI Applications
distrobox-export --app codium

# Services
distrobox-export --service syncthing --extra-flags "--allow-newer-config"

# Binaries
distrobox-export --bin /usr/bin/vim -export-path ~/.local/bin
```