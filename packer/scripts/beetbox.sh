#!/bin/bash

# Install git.
apt-get -y install git

# beetbox dir.
BEETBOX_HOME="/beetbox"

# Checkout beetbox.
mkdir -p $BEETBOX_HOME
git clone https://github.com/drupalmel/beetbox.git $BEETBOX_HOME

# Provision box.
chmod +x $BEETBOX_HOME/ansible/build.sh
$BEETBOX_HOME/ansible/build.sh
