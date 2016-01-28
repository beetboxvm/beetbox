#!/bin/bash

# Fix hash mismatch errors
# https://bugs.launchpad.net/ubuntu/+source/debian-installer/+bug/1430648
rm -rf /var/lib/apt/lists/*
apt-get clean
apt-get autoremove

# Update the box
apt-get -y update
apt-get -y upgrade

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub
