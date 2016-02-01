# Beetbox - Drupal development on Vagrant

Beetbox is a Vagrant configuration that provides your team with a versatile development environment for Drupal projects using Virtualbox for VMs (virtual machines).

The project has a defined set of default configuration attributes so it will work without any custom configuration. All customisation comes in the form of overrides as undefined attributes will revert to the default.

[![Circle CI](https://circleci.com/gh/drupalmel/beetbox.svg?style=svg)](https://circleci.com/gh/drupalmel/beetbox) [![Documentation Status](https://readthedocs.org/projects/beetbox/badge/?version=latest)](http://beetbox.readthedocs.org/en/latest/?badge=latest)


## Features

* Support for different VMs per branch.
* Takes advantage of Vagrant 1.8's linked clones support to manage VMs for speed and disk efficiency.
* Uses ansible 2 for provision but it's not required on the host machine.


## Requirements

* [Vagrant](https://www.vagrantup.com/) >= 1.8
* [Virtualbox](https://www.virtualbox.org/)
* (Windows only) [Vagrant::Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)
* (Windows only) [Vagrant Auto-network](https://github.com/oscar-stack/vagrant-auto_network)


## Quickstart

To get a simple Drupal site up and running with Beetbox, run the following commands:

```
drush dl drupal-8.0.2
cd drupal-8.0.2
vagrant init DrupalMel/beetbox
vagrant up
```

After which you can install the site at http://drupal-8-0-2.local/install.php


## Support

* Feature requests should be created on [FeatHub](http://feathub.com/drupalmel/beetbox)
* Bugs should be reported in the [GitHub Beetbox Issue Queue](https://github.com/drupalmel/beetbox/issues)
* Use pull requests (PRs) to contribute to Beetbox.


## Credits
This would not be possible without [geerlingguy's](https://github.com/geerlingguy) awesome ansible roles from [Drupal VM](https://github.com/geerlingguy/drupal-vm).

We encourage you to support him by buying his book [Ansible for DevOps](http://ansiblefordevops.com/).

Beetbox is primarily maintained by the Drupal Melbourne (Australia) community. Please follow [@beetboxvm](https://twitter.com/beetboxvm)for announcements.
