#!/bin/bash -eu

# Set default environment variables.
BEET_HOME=${BEET_HOME:-"/beetbox"}
BEET_BASE=${BEET_BASE:-"/var/beetbox"}
BEET_USER=${BEET_USER:-"vagrant"}
BEET_REPO=${BEET_REPO:-"https://github.com/beetboxvm/beetbox.git"}
BEET_VERSION=${BEET_VERSION:-"master"}
BEET_TAG=${BEET_TAG:-""}
BEET_DEBUG=${BEET_DEBUG:-false}
CIRCLECI=${CIRCLECI:-false}
ANSIBLE_HOME="$BEET_HOME/provisioning/ansible"
ANSIBLE_DEBUG=""

# Ansible config.
export DISPLAY_SKIPPED_HOSTS=${DISPLAY_SKIPPED_HOSTS:-False}
export ANSIBLE_DEPRECATION_WARNINGS=${ANSIBLE_DEPRECATION_WARNINGS:-False}
export ANSIBLE_REMOTE_TEMP=${ANSIBLE_REMOTE_TEMP:-/tmp}

# Enable debug mode?
if [ $BEET_DEBUG = "true" ]; then
  set -x
  ANSIBLE_DEPRECATION_WARNINGS=True
  ANSIBLE_DEBUG="-vvv"
fi

# Circle CI defaults.
if [ "$CIRCLECI" == "true" ]; then
  [ $BEET_BASE == "/var/beetbox" ] && export BEET_BASE="/home/ubuntu/$CIRCLE_PROJECT_REPONAME"
  [ $BEET_USER == "vagrant" ] && export BEET_USER="ubuntu"
fi

beetbox_setup()
{
  # Create BEET_USER and setup sudo.
  [ -z "$(getent passwd $BEET_USER)" ] && sudo useradd -d /home/$BEET_USER -m $BEET_USER > /dev/null 2>&1
  echo "$BEET_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$BEET_USER

  # Install ansible.
  sudo apt-get -qq -y install software-properties-common
  sudo apt-add-repository -y ppa:ansible/ansible > /dev/null 2>&1
  sudo apt-get -qq update
  sudo apt-get -qq -y install ansible

  # Clone beetbox if BEET_HOME doesn't exist.
  if [ ! -d "$BEET_HOME" ]; then
    sudo apt-get -y install git
    sudo mkdir -p $BEET_HOME
    sudo chown -R $BEET_USER:$BEET_USER $BEET_HOME
    echo "==> Checking out beetbox from $BEET_REPO"
    git clone $BEET_REPO $BEET_HOME
    rm -f $BEET_HOME/.beetbox/config.yml
    [ ! -d "$BEET_HOME" ] && exit 1
  fi

  # Check version.
  beetbox_play config && beetbox_play update

  # Beetbox setup.
  beetbox_play setup

  # Create $BEET_HOME/.beetbox_installed
  sudo touch $BEET_HOME/.beetbox/installed
}

beetbox_play()
{
  ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ansible-playbook $ANSIBLE_DEBUG $ANSIBLE_HOME/playbook-$1.yml -i 'localhost,'
}

# Initialise beetbox.
[ ! -f "$BEET_HOME/.beetbox/installed" ] && beetbox_setup

# Create default config files.
beetbox_play config

# Check for updates.
beetbox_play update

# Install ansible galaxy roles.
beetbox_play roles

# Provision VM.
beetbox_play provision

# Run tests on Circle CI.
([ "$CIRCLECI" == "true" ] || [ "$BEET_DEBUG" == "true" ]) && beetbox_play tests

# Print welcome message.
sudo touch $BEET_HOME/.beetbox/welcome.txt
sudo cat $BEET_HOME/.beetbox/welcome.txt
