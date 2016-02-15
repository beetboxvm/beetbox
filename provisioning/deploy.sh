#!/bin/bash -e

# Set default environment variables.
ATLAS_BOX="$BEET_BOX-dev"
ATLAS_VERSION=${BEET_VERSION:-"0.1.$CIRCLE_BUILD_NUM"}
BEET_VERSION=${CIRCLE_BRANCH:-"dev"}
BEET_TEMPLATE=${BEET_TEMPLATE:-"template.json"}
PACKER_HOME=${PACKER_HOME:-"$BEET_HOME/provisioning"}

# Use prod atlas build and tag for version.
if [ ! $CIRCLE_TAG = "" ]; then
  ATLAS_BOX="$BEET_BOX"
  ATLAS_VERSION="$CIRCLE_TAG"
  BEET_VERSION="$CIRCLE_TAG"
fi

cd $PACKER_HOME

# Update template variables.
sed -i "s/ATLAS_VERSION/$ATLAS_VERSION/" $BEET_TEMPLATE
sed -i "s/BEET_VERSION/$BEET_VERSION/" $BEET_TEMPLATE

# Trigger new build.
packer push -token=$ATLAS_TOKEN -name="$ATLAS_BOX" $BEET_TEMPLATE
