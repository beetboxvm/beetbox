#!/bin/bash

# Current directory.
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create default config files.
touch "$currentDir/beetbox.config.yml"
touch "$currentDir/project.config.yml"
touch "$currentDir/vagrant.config.yml"
touch "$currentDir/local.config.yml"

# Set environment variables.
export ANSIBLE_FORCE_COLOR=1
export DISPLAY_SKIPPED_HOSTS=False
export PYTHONUNBUFFERED=1

# Enable debug mode.
[[ $BEETBOX_DEBUG ]] && DEBUG="-vvv" || DEBUG=""

# Check for updates.
ansible-playbook $DEBUG "$currentDir/playbook-update.yml" -i 'localhost,'

# Install ansible galaxy roles.
ansible-playbook $DEBUG "$currentDir/playbook-roles.yml" -i 'localhost,'

# Provision VM.
ansible-playbook $DEBUG "$currentDir/playbook-provision.yml" -i 'localhost,'

# Print welcome message.
touch /home/vagrant/welcome.txt
cat /home/vagrant/welcome.txt
