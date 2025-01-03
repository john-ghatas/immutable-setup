# How to use the script
With the nature of fedora Silverblue/Kinoite multiple reboots are needed to get the initial setup steps done. The following order of the script is needed to make this work, **Please take note of what dedicated/primary GPU your system is using (AMD/INTEL/NVIDIA)**:

A total overview of the raw images is provided in https://github.com/orgs/ublue-os/packages

For rebasing to the desired image please use the instructions provided in https://universal-blue.discourse.group/docs?topic=868

## Recommended images and quickstart

I would recommend using either [Bluefin (GNOME)](https://projectbluefin.io/) or [Aurora(KDE)](https://getaurora.dev/)

### Install options

You can install by grabbing the ISO from the websites mentioned above directly or rebase from an existing installation

### Rebasing
When rebasing you can pick between 2 variants; the normal edition and the developer edition which will yield extras like pre-installed `brew`, `docker` and Kubernetes libraries.

The tags used in this example are for Fedora 40, you can replace the `40` with `gts` (Current Fedora version - 1) or `latest`.

**Bluefin**
```
# Normal variant - Example is the Fedora 40 spin
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/bluefin:40
-> Reboot
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bluefin:40

# Developer Edition
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/bluefin-dx:40
-> Reboot
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bluefin-dx:40
```

**Aurora**
```
# Normal variant - Example is the Fedora 40 spin
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/aurora:40
-> Reboot
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/aurora:40

# Developer Edition
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/aurora-dx:40
-> Reboot
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/aurora-dx:40
```

## Post-rebase
After you have rebased to a uBlue image run the suit of scripts

- `./post-rebase.sh`
    - If you run an AMD/Intel system this is the only operation needed
    - After running the script import the secure boot key [optional, but highly recommended]
    ```
    ujust enroll-secure-boot-key
    ```
    The default password is noted in https://github.com/ublue-os/bluefin?tab=readme-ov-file#secure-boot if it isn't printed out in the terminal.

- If you have an NVIDIA card installed and you have the Nvidia spins installed run the nvidia-post.sh script
    - `./nvidia-steps.sh`
    - Import the uBlue keys to MOK 
        ```
        just enroll-secure-boot-key
        ``` 
        - The password is to be created (should not be complicated, it's just a verification that you wanted the certirficate installed). For example it can only be a <5 character password, it's a one time password to enroll the keys.
        - After reboot import the certificate when the MOK screen shows up (input the password you used to create the certificate)
    - After reboot check if the driver is loaded with `nvidia-smi`
    - The output should look like this
        ```
        ❯ nvidia-smi
        Sat May  6 11:55:57 2023       
        +---------------------------------------------------------------------------------------+
        | NVIDIA-SMI 530.41.03              Driver Version: 530.41.03    CUDA Version: 12.1     |
        ```


# EXTRA NOTES
## Using GPG with a 
Due to a clash with PCSCD it recommended to disable the systemd service
```
sudo systemctl stop {pcscd,pcscd.socket
```

## PGP Mail client
If you are trying to get PGP Mailing working with Thunderbird follow the steps mentioned below (**only concerning the PGP mailing with smartcards**): 

- Create a Fedora distrobox `distrobox-create --name fedora --image fedora:37`

- Enter the distrobox with `distrobox enter fedora` 

- Install the following packages `sudo dnf install gpgme pcsc-lite gpg thunderbird`

- Export the application to your Silverblue system `distrobox-export --app thunderbird`

- Follow this [page](https://anweshadas.in/how-to-use-yubikey-or-any-gpg-smartcard-in-thunderbird-78/#:~:text=Configure%20the%20secret%20key%20usage%20form%20Yubikey&text=Type%20your%20Secret%20Key%20ID,your%20hardware%20token%20in%20Thunderbird.) to set Thunderbird up to work with your smartcard.

## Install devpod-cli in userspace
```
curl -L -o ~/.local/bin/devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && chmod 755 ~/.local/bin/devpod
```

## Install devbox
Devbox is most commonly used to make shippable development environments
```
curl -fsSL https://get.jetify.com/devbox | bash
```

## Changing the shell for the current user to ZSH
```
sudo usermod --shell $(which zsh) $USER
```

## Install A GTK4 compliant theme (do this in a distrobox)
```
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
<go to dir>
./install.sh -m --darker -l -c Dark -N glassy -o normal
```

Vimix theme
```
git clone https://github.com/vinceliuice/vimix-gtk-themes.git
cd <dir>
./install.sh -l -t ruby -c dark -s compact
```

Fluent GTK
```
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
cd <dir>
./install.sh -l -d ~/.themes -i fedora -s standard -c dark --tweaks round noborder blur
```

Orchis
```
# Example is from Gnome 44
git clone https://github.com/vinceliuice/Orchis-theme.git
cd <dir>
./install.sh -l -c dark -t teal --tweaks compact macos black submenu --round 5 --shell 44
```

## Yubikey Issues
YubiKeys can be problematic when PIV mode is enabled, disable PIV mode with ykman (install it in a distrobox or overlay it which ever you prefer) and it should be picked up by GnuPG
