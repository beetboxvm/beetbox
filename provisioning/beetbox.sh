#!/bin/bash -eu

# Set default environment variables.
export BEET_PROFILE=${BEET_PROFILE:-beetbox}
BEET_PLAYBOOK=${BEET_PLAYBOOK:-provision}
BEET_TAGS=${BEET_TAGS:-all}
BEET_HOME=${BEET_HOME:-"/beetbox"}
BEET_BASE=${BEET_BASE:-"/var/beetbox"}
BEET_USER=${BEET_USER:-"vagrant"}
BEET_REPO=${BEET_REPO:-"https://github.com/beetboxvm/beetbox.git"}
BEET_VERSION=${BEET_VERSION:-"master"}
BEET_DEBUG=${BEET_DEBUG:-false}
ANSIBLE_HOME="$BEET_HOME/provisioning/ansible"
ANSIBLE_DEBUG=""

# Ansible config.
export DISPLAY_SKIPPED_HOSTS=${DISPLAY_SKIPPED_HOSTS:-False}
export ANSIBLE_DEPRECATION_WARNINGS=${ANSIBLE_DEPRECATION_WARNINGS:-False}
export ANSIBLE_REMOTE_TEMP=${ANSIBLE_REMOTE_TEMP:-/tmp}
export ANSIBLE_RETRY_FILES_ENABLED=${ANSIBLE_RETRY_FILES_ENABLED:-False}
export ANSIBLE_FORCE_COLOR=${ANSIBLE_FORCE_COLOR:-True}
export ANSIBLE_INVENTORY=${ANSIBLE_INVENTORY:-"localhost,"}
export PYTHONUNBUFFERED=${PYTHONUNBUFFERED:-True}

# Enable debug mode?
if [[ "$BEET_DEBUG" = "true" ]]; then
  export ANSIBLE_DEPRECATION_WARNINGS=True
  ANSIBLE_DEBUG="-vvv"
fi

beetbox_setup() {
  # Create BEET_USER and setup sudo.
  [[ -z "$(getent passwd "$BEET_USER")" ]] && sudo useradd -d "/home/$BEET_USER" -m "$BEET_USER" > /dev/null 2>&1
  echo "$BEET_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/$BEET_USER" > /dev/null 2>&1

  # Install ansible.
  if [[ ! -d "/etc/ansible" ]]; then
    sudo apt-get -qq update
    sudo apt-get -y install software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get -qq update
    sudo apt-get -y install ansible
  fi

  # Clone beetbox if BEET_HOME doesn't exist.
  if [[ ! -d "$BEET_HOME" ]]; then
    beetbox_adhoc apt "name=git state=installed"
    beetbox_adhoc git "repo=$BEET_REPO dest=$BEET_HOME depth=1 recursive=yes"
    beetbox_adhoc file "path=$BEET_HOME owner=$BEET_USER group=$BEET_USER"
    beetbox_adhoc file "path=$BEET_HOME/.beetbox/config.yml state=absent"
    beetbox_adhoc file "src=$BEET_HOME/provisioning/beetbox.sh dest=/usr/local/bin/beetbox state=link mode=755"
    [[ ! -d "$BEET_HOME" ]] && exit 1
  fi

  # Check version.
  beetbox_play config && beetbox_play update

  # Beetbox setup.
  beetbox_play setup

  # Create $BEET_HOME/.beetbox_installed
  beetbox_adhoc file "path=$BEET_HOME/installed state=touch"
}

beetbox_adhoc() {
  ansible ${ANSIBLE_DEBUG} localhost -m "${1}" -a "${2}" --become -c local
}

beetbox_play() {
  ansible-playbook ${ANSIBLE_DEBUG} "${ANSIBLE_HOME}/playbook-${1}.yml" --tags "${2:-all}"
}

# Initialise beetbox.
[[ ! -f "$BEET_HOME/installed" ]] && beetbox_setup

# Create default config files.
beetbox_play config

# Check for updates.
beetbox_play update

# Provision VM.
beetbox_play "$BEET_PLAYBOOK" "$BEET_TAGS"

# Print welcome message.
sudo touch "$BEET_HOME/results-$BEET_PLAYBOOK.txt"
sudo cat "$BEET_HOME/results-$BEET_PLAYBOOK.txt"
