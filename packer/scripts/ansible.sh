#!/bin/bash

# Install ansible.
apt-get -y update
apt-get -y install python-pip python-dev
pip install ansible==2.0.0.2
