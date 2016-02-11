#!/bin/bash -e

# Set default environment variables.
export ANSIBLE_VERSION=${ANSIBLE_VERSION:="2.0.0.2"}
export BEET_HOME=${BEET_HOME:="/beetbox"}
export BEET_BASE=${BEET_BASE:="/var/beetbox"}
export BEET_USER=${BEET_USER:="vagrant"}
export BEET_REPO=${BEET_REPO:="https://github.com/drupalmel/beetbox.git"}
export BEET_BRANCH=${BEET_BRANCH:="master"}
export ANSIBLE_FORCE_COLOR=${ANSIBLE_FORCE_COLOR:=1}
export DISPLAY_SKIPPED_HOSTS=${DISPLAY_SKIPPED_HOSTS:=False}
export ANSIBLE_DEPRECATION_WARNINGS=${ANSIBLE_DEPRECATION_WARNINGS:=False}
export ANSIBLE_REMOTE_TEMP=${ANSIBLE_REMOTE_TEMP:=/tmp}
export PYTHONUNBUFFERED=${PYTHONUNBUFFERED:=1}
export ANSIBLE_HOME="$BEET_HOME/provisioning/ansible"
export ANSIBLE_INVENTORY="'localhost,'"

if [ ! -f "$BEET_HOME/.beetbox/installed" ]; then

  # Remove default circle CI packages.
  if [ "$CIRCLECI" == "true" ]; then
    echo "Removing default circle CI packages"
    sudo apt-get -qq update
    sudo apt-get -y purge apache2 php5-cli mysql-common mysql-server mysql-common
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
    sudo rm -rf /etc/apache2/mods-enabled/*
    sudo rm -rf /var/lib/mysql
  fi

  # Install ansible.
  sudo apt-get -y install python-pip python-dev
  sudo -H pip install ansible==$ANSIBLE_VERSION

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

fi

# Enable debug mode.
if [ $BEETBOX_DEBUG ]; then
  export DEPRECATION_WARNINGS=True
  export ANSIBLE_DEBUG="-vvv"
fi

# Create default config files.
ansible-playbook $ANSIBLE_DEBUG "$ANSIBLE_HOME/playbook-config.yml" -i $ANSIBLE_INVENTORY

# Check for updates.
ansible-playbook $ANSIBLE_DEBUG "$ANSIBLE_HOME/playbook-update.yml" -i $ANSIBLE_INVENTORY

# Install ansible galaxy roles.
ansible-playbook $ANSIBLE_DEBUG "$ANSIBLE_HOME/playbook-roles.yml" -i $ANSIBLE_INVENTORY

# Provision VM.
ansible-playbook $ANSIBLE_DEBUG "$ANSIBLE_HOME/playbook-provision.yml" -i $ANSIBLE_INVENTORY

# Run tests on Circle CI.
[ "$CIRCLECI" == "true" ] && ansible-playbook $ANSIBLE_DEBUG "$ANSIBLE_HOME/playbook-tests.yml" -i $ANSIBLE_INVENTORY

# Print welcome message.
touch ~/welcome.txt
cat ~/welcome.txt
