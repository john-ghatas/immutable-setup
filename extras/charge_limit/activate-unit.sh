SCRIPT_DIR=$(dirname "$0")
cd $SCRIPT_DIR
sudo cp unitfile /etc/systemd/system/battery-charge-threshold.service
sudo systemctl enable --now battery-charge-threshold.service
