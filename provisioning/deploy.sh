#!/bin/bash -e

# Set default environment variables.
ATLAS_BOX="$BEET_BOX-dev"
ATLAS_VERSION=${BEET_VERSION:-"0.1.$CIRCLE_BUILD_NUM"}
BUILD_VERSION=${CIRCLE_BRANCH:-"dev"}
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
[ $ATLAS_BOX = "$BEET_BOX-dev" ] && sed -i "s/abef0f6a03cc23bb3da842cd1d12aa50/ef43117dab9c8e5d10a6b7d72d2e3fc4/" $PACKER_VAGRANTFILE

# Trigger new build.
packer push -token=$ATLAS_TOKEN -name="$ATLAS_BOX" $BEET_TEMPLATE
