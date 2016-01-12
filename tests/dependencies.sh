#!/bin/bash

sudo pip install ansible==1.9.4
sudo apt-get update
sudo apt-get purge apache2 php5-cli mysql-common mysql-server
sudo rm -rf /etc/apache2/mods-enabled/*

if [ ! -d "$BEETBOX_HOME" ]; then
  sudo apt-get install git
  git clone https://github.com/drupalmel/beetbox.git $BEETBOX_HOME
fi

sudo $BEETBOX_HOME/ansible/build.sh
