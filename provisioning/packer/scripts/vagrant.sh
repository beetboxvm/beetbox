#!/bin/bash

# Set up sudo
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant

# Vagrant specific
date > /etc/vagrant_box_build_time

# Create a ssh config file so we don't have to approve every new host.
mkdir -pm 700 /root/.ssh
echo "Host *drupal.org
    StrictHostKeyChecking no
Host *github.com
    StrictHostKeyChecking no
Host *bitbucket.org
    StrictHostKeyChecking no
Host *acquia.com
    StrictHostKeyChecking no
Host *drush.in.com
    StrictHostKeyChecking no
" > /root/.ssh/config
chmod 600 /root/.ssh/config

# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
cp /root/.ssh/config /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/config
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# fix vagrant no tty errors
# http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
sed -i '/tty/!s/mesg n/tty -s \&\& mesg n/' /root/.profile
