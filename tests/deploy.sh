#!/bin/bash

# Install packer.
wget https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip
unzip packer_0.8.6_linux_amd64.zip -d ~/packer

# Trigger new build.
cd ~/$CIRCLE_PROJECT_REPONAME/packer
sed -i "s/BEET_VERSION/$BEET_VERSION/" template.json
~/packer/packer push -token=$ATLAS_TOKEN -name="DrupalMel/$BEET_BOX" template.json
