#!/bin/sh

sudo tee /etc/NetworkManager/conf.d/00-wifi-powersave.conf << EOF > /dev/null
[connection]
wifi.powersave=2
EOF
sudo systemctl restart NetworkManager.service
