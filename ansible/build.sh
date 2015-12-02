#!/bin/bash

# Create default config files.
touch /ansible/beetbox.config.yml
touch /ansible/project.config.yml
touch /ansible/vagrant.config.yml
touch /ansible/local.config.yml

# Set environment variables.
export ANSIBLE_FORCE_COLOR=1
export PYTHONUNBUFFERED=1

# Install role dependancies.
ansible-playbook /ansible/playbook-roles.yml

# Provision VM.
ansible-playbook /ansible/playbook-provision.yml
