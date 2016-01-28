#!/bin/bash

sudo pip install ansible==2.0.0.2
sudo apt-get update
sudo apt-get purge apache2 php5-cli mysql-common mysql-server
sudo rm -rf /etc/apache2/mods-enabled/*

if [ ! -d "$BEET_HOME" ]; then
  sudo apt-get install git
  git clone https://github.com/drupalmel/beetbox.git $BEET_HOME
fi

sudo su -c $BEET_HOME/ansible/build.sh
