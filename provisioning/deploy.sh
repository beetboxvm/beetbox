#!/bin/bash -e

# Set default environment variables.
ATLAS_BOX="beet/dev"
ATLAS_VERSION=${BEET_VERSION:-"0.1.$CIRCLE_BUILD_NUM"}
BUILD_VERSION=${CIRCLE_BRANCH:-"master"}
BEET_TEMPLATE=${BEET_TEMPLATE:-"template.json"}
PACKER_HOME=${PACKER_HOME:-"$BEET_HOME/provisioning"}
PACKER_VAGRANTFILE=${PACKER_VAGRANTFILE:="$PACKER_HOME/packer/includes/Vagrantfile"}

# Use prod atlas build and tag for version.
if [ ! $CIRCLE_TAG = "" ]; then
  ATLAS_BOX="$BEET_BOX"
  ATLAS_VERSION="$CIRCLE_TAG"
  BUILD_VERSION="$CIRCLE_TAG"
fi

cd $PACKER_HOME

# Update template variables.
sed -i "s/ATLAS_VERSION/$ATLAS_VERSION/" $BEET_TEMPLATE
sed -i "s/BUILD_VERSION/$BUILD_VERSION/" $BEET_TEMPLATE

# Update box Vagrantfile hash on dev builds.
[ $ATLAS_BOX = "beet/dev" ] && sed -i "s/ef550c44b71ef09513fe24c4b564c8a9/c704fbc0a4343dcd6778896a150604b5/" $PACKER_VAGRANTFILE

# Trigger new build.
packer push -token=$ATLAS_TOKEN -name="$ATLAS_BOX" $BEET_TEMPLATE
