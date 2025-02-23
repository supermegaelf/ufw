#!/bin/bash

apt update && apt install -y ufw

ufw allow 443/tcp comment "HTTPS (Reality)"
ufw allow 22/tcp comment "SSH"

ufw enable

mkdir -p /root/scripts && cd /root/scripts

wget -q https://raw.githubusercontent.com/supermegaelf/cf-ufw/main/cf-ufw.sh -O /root/scripts/cf-ufw.sh

chmod +x /root/scripts/cf-ufw.sh

bash /root/scripts/cf-ufw.sh

apt install -y cron
(crontab -l 2>/dev/null; echo "@daily /root/scripts/cf-ufw.sh &> /dev/null") | crontab -

ufw reload
