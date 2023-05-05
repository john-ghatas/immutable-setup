e!/bin/bash
echo "Setting up packages" 
rpm-ostree install android-tools docker gnome-shell-extension-user-theme neovim tilix zsh

# Install repo version of distrobox 
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

# Enable the rpmfusion repos
sudo sed -i "s/enabled=0/enabled=1/" /etc/yum.repos.d/rpmfusion-{free,nonfree}{.repo,-updates.repo}

echo "Please reboot again to make the changes final" 
