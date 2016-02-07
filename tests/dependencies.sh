#!/bin/bash

# Install ansible and remove default packages.
sudo pip install ansible==2.0.0.2
sudo apt-get update
sudo apt-get purge apache2 php5-cli mysql-common mysql-server
sudo rm -rf /etc/apache2/mods-enabled/*

# Create BEET_BASE if it doesn't exist.
if [ ! -d "$BEET_BASE" ]; then
  sudo mkdir -p $BEET_BASE
fi

# Clone beetbox if BEET_HOME doesn't exist.
if [ ! -d "$BEET_HOME" ]; then
  sudo apt-get install git
  git clone https://github.com/drupalmel/beetbox.git $BEET_HOME
fi

# Provision instance.
. $BEET_HOME/ansible/build.sh
