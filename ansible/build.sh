#!/bin/bash -e

# Set BEET_HOME.
BEET_HOME=${BEET_HOME:="/beetbox"}

# Source environment variables
BEET_SH="$BEET_HOME/packer/scripts/beetbox.sh"
[ -f "$BEET_SH" ] && . $BEET_SH

# Set environment variables.
export ANSIBLE_FORCE_COLOR=${ANSIBLE_FORCE_COLOR:=1}
export DISPLAY_SKIPPED_HOSTS=${DISPLAY_SKIPPED_HOSTS:=False}
export ANSIBLE_DEPRECATION_WARNINGS=${ANSIBLE_DEPRECATION_WARNINGS:=False}
export PYTHONUNBUFFERED=${PYTHONUNBUFFERED:=1}
export ANSIBLE_HOME="$BEET_HOME/ansible"
export ANSIBLE_INVENTORY="'localhost,'"

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

# Print welcome message.
touch ~/welcome.txt
cat ~/welcome.txt
