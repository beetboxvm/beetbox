#!/bin/bash -e

# Set default environment variables.
ANSIBLE_VERSION=${ANSIBLE_VERSION:="2.0.0.2"}
BEET_HOME=${BEET_HOME:="/beetbox"}
BEET_BASE=${BEET_BASE:="/var/beetbox"}
BEET_USER=${BEET_USER:="vagrant"}
BEET_REPO=${BEET_REPO:="https://github.com/drupalmel/beetbox.git"}
BEET_BRANCH=${BEET_BRANCH:="master"}

if [ ! -f "$BEET_HOME/.beetbox/installed" ]; then

  # Install ansible.
  sudo apt-get -y install python-pip python-dev
  sudo -H pip install ansible==$ANSIBLE_VERSION

  # Remove default packages.
  sudo apt-get -qq update
  sudo apt-get -y purge apache2 php5-cli mysql-common mysql-server
  sudo rm -rf /etc/apache2/mods-enabled/*

  # Clone beetbox if BEET_HOME doesn't exist.
  if [ ! -d "$BEET_HOME" ]; then
    sudo apt-get -y install git
    sudo mkdir -p $BEET_HOME
    sudo chown -R $BEET_USER:$BEET_USER $BEET_HOME
    git clone --branch $BEET_BRANCH $BEET_REPO $BEET_HOME
  fi

  # Create BEET_BASE if it doesn't exist.
  if [ ! -d "$BEET_BASE" ]; then
    sudo mkdir -p $BEET_BASE
  fi

  # Attempt to set ownership/permissions of BEET_HOME and BEET_BASE.
  sudo chown -R $BEET_USER:$BEET_USER $BEET_HOME $BEET_BASE 2> /dev/null || :
  sudo chmod -R 775 $BEET_HOME $BEET_BASE 2> /dev/null || :

  # Create $BEET_HOME/.beetbox_installed
  touch $BEET_HOME/.beetbox/installed

  # Provision instance.
  . $BEET_HOME/ansible/build.sh

fi
