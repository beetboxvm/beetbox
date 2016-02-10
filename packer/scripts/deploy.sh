#!/bin/bash -e

# Install packer.
if [ ! -f "~/packer/packer" ]; then
  wget https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip
  unzip packer_0.8.6_linux_amd64.zip -d ~/packer
fi

# Trigger new build.
cd ~/$CIRCLE_PROJECT_REPONAME/packer
sed -i "s/BEET_VERSION/$BEET_VERSION/" $BEET_TEMPLATE
~/packer/packer push -token=$ATLAS_TOKEN -name="DrupalMel/$BEET_BOX" $BEET_TEMPLATE
