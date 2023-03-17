# How to use the script
With the nature of fedora Silverblue/Kinoite multiple scripts are needed with multiple reboot. The following order of the script is needed to make this work, **Please take note of what dedicated/primary GPU your system is using (AMD/INTEL/NVIDIA)**:

- `./init-setup.sh`
- Reboot
- `./post-reboot.sh` 
    - In case of an AMD system run the following command and then reboot
    - `rpm-ostree override remove mesa-vdpau-drivers --install mesa-vdpau-drivers-freeworld`
    - In case of an Intel system run the following command and then reboot
    - `rpm-ostree install intel-media-driver`
- Reboot again -> You can choose to install the NVIDIA drivers on the current cycle, please note in case of any issues this will be harder to isolate
    - If you want docker to work you need to run these commands to add the right permissions
```
sudo su -
grep -E '^docker:' /usr/lib/group >> /etc/group
usermod -aG docker <your_user>
```

- **Only run this step if you have an NVIDIA gpu**
    - `./nvidia-setup.sh`
    - If the NVIDIA gpu is your primary display output (in case of a desktop etc.) run the following command
    - `rpm-ostree install nvidia-vaapi-driver`
    - Reboot again

You are done, I provided an upgrade script as well in case you need to upgrade Kinoite/Silverblue


The `upgrade.sh` script is provided in case of a new major version, run the script by issueing the following command `./upgrade.sh`. The output will look like this:
```
./upgrade.sh
What version of Fedora are you upgrading to? (37, 38 etc): 38
Upgrading to Fedora 38 from Fedora 37
Press any key to continue....  
```

If you encounter issues with the regular upgrade script try using the `./upgrade-alternate.sh` script.

# EXTRA NOTES

## PGP Mail client
If you are trying to get PGP Mailing working with Thunderbird follow the steps mentioned below (**only concerning the PGP mailing with smartcards**): 

- Create a Fedora toolbox `distrobox-create --name fedora --image fedora:37`

- Enter the distrobox with `distrobox enter fedora` 

- Install the following packages `sudo dnf install gpgme pcsc-lite gpg thunderbird`

- Export the application to your Silverblue system `distrobox-export --app thunderbird`

- Follow the mentioned [page](https://anweshadas.in/how-to-use-yubikey-or-any-gpg-smartcard-in-thunderbird-78/#:~:text=Configure%20the%20secret%20key%20usage%20form%20Yubikey&text=Type%20your%20Secret%20Key%20ID,your%20hardware%20token%20in%20Thunderbird.) to set Thunderbird up to work with your smartcard.


## Changing the shell for the current user to ZSH
`sudo usermod --shell $(which zsh) $USER`
