#!/bin/bash -eu

# Set default environment variables.
ATLAS_BOX="$BEET_BOX-dev"
BEET_VERSION=${BEET_VERSION:-"0.1.$CIRCLE_BUILD_NUM"}
BEET_TEMPLATE=${BEET_TEMPLATE:-"template.json"}
PACKER_HOME=${PACKER_HOME:-"~/$CIRCLE_PROJECT_REPONAME/provisioning"}

# Use prod atlas build and tag for version.
if [ $CIRCLE_TAG ]; then
  ATLAS_BOX="$BEET_BOX"
  BEET_VERSION="$CIRCLE_TAG"
fi

# Update template variables.
sed -i "s/BEET_VERSION/$BEET_VERSION/" $BEET_TEMPLATE

# Trigger new build.
cd $PACKER_HOME ; packer push -token=$ATLAS_TOKEN -name="$ATLAS_BOX" $BEET_TEMPLATE
