#!/bin/bash

# Install ansible.
apt-get -y update
apt-get -y install python-pip python-dev
pip install ansible==1.9.4
