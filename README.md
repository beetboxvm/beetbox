# Beetbox - a pre-provisioned L*MP stack

A VM for local L*MP development, built with Packer, Vagrant + Ansible

Beetbox is essentially a pre-provisioned version of [Drupal VM](http://www.drupalvm.com/) mainly to speed up initial virtual machine build time, but also to reduce the size of each VM by leveraging [linked clones](https://www.hashicorp.com/blog/vagrant-1-8.html).

Whilst it contains a set of default feature configuration, it is extremely extensible and almost anything can be overridden/extended with a simple YAML config file.

It is designed to have an instance (VM) per project and be integrated into a VCS like git, so that configuration can be easily shared within a team and a setup of a new project should be as simple as `git clone ...; vagrant up`.

This particular project contains the plumbing to manage the automated build of the pre-provisioned Vagrant base box, so almost all functionality is provided by ansible roles external to this project.

[![Circle CI](https://circleci.com/gh/beetboxvm/beetbox.svg?style=shield)](https://circleci.com/gh/beetboxvm/beetbox) [![Documentation Status](https://readthedocs.org/projects/beetbox/badge/?version=stable)](http://beetbox.readthedocs.org/en/stable/?badge=stable)
[![Latest Stable Version](https://poser.pugx.org/beet/box/v/stable)](https://packagist.org/packages/beet/box)
[![Total Downloads](https://poser.pugx.org/beet/box/downloads)](https://packagist.org/packages/beet/box)
[![License](https://poser.pugx.org/beet/box/license)](https://packagist.org/packages/beet/box)
[![Docker](https://img.shields.io/docker/build/beet/box.svg)](https://hub.docker.com/r/beet/box/builds/)

## What's different about this project?

* It's a composer plugin which automatically creates a Vagrantfile.
* You only add config to your project and don't need to manage a fork of the whole provisioning system.
* It uses a pre-provisioned base box so it’s much faster to provision.
* Each new version of the box gets published to Atlas only if all roles are provisioned making the box always stable.
* With linked clones each VM is a small clone of a single master.
* You can reuse the same provisioning system for a CI environment.
* Minimal host machine dependencies.

## Requirements

* [Composer](https://getcomposer.org/download/)
* [Vagrant](https://www.vagrantup.com/) >= 1.8
* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)
```
vagrant plugin install vagrant-hostsupdater
```
* [Vagrant Auto-network](https://github.com/oscar-stack/vagrant-auto_network)
```
vagrant plugin install vagrant-auto_network
```

## Quickstart

```
composer require --dev beet/box
vagrant up
```

This will automatically generate a Vagrantfile and the `.beetbox` directory, which will contain a `config.yml` file used to configure overrides.

You can see some examples in [`config.yml`](https://github.com/beetboxvm/beetbox/blob/master/.beetbox/config.yml)

## Updating

```
composer update beet/box
```

Version constraints should automatically keep you to the same minor release. `(0.0.x)`
However, you may need to update your configuation when upgrading minor releases. `(0.x.0)`
See the release notes for more information.

## Drupal Quickstart

To get a simple Drupal 8 site up and running with Beetbox, run the following commands:

```
composer create-project drupal-composer/drupal-project:8.x-dev drupal8 --stability dev --no-interaction
cd drupal8
composer require --dev beet/box
vagrant up
```

After which you can install the site at [http://drupal8.local/install.php](http://drupal8.local/install.php)

or add the following to `./.beetbox/config.yml` and run `vagrant provision` to automatically install drupal:

```
drupal_install_site: yes
drupal_account_name: admin
drupal_account_pass: admin
```

For PHP 5.6 add `php_version: "5.6"` to `./.beetbox/config.yml`, then run `vagrant provision`.

## Project roles.

These roles are mantained by Beetbox team.

| Project | Build status |
| --- | --- |
| [Backdrop](https://github.com/beetboxvm/ansible-role-beetbox-backdrop) | [![Circle CI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-backdrop.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-backdrop) |
| [Drupal](https://github.com/beetboxvm/ansible-role-beetbox-drupal) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-drupal.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-drupal) |
| [Kohana](https://github.com/beetboxvm/ansible-role-beetbox-kohana) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-kohana.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-kohana) |
| [Modx](https://github.com/beetboxvm/ansible-role-beetbox-modx) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-modx.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-modx) |
| [Silverstripe](https://github.com/beetboxvm/ansible-role-beetbox-silverstripe) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-silverstripe.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-silverstripe) |
| [Slim](https://github.com/beetboxvm/ansible-role-beetbox-slim) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-slim.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-slim) |
| [Symfony](https://github.com/beetboxvm/ansible-role-beetbox-symfony) | [![Circle CI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-symfony.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-symfony) |
| [Wordpress](https://github.com/beetboxvm/ansible-role-beetbox-wordpress) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-wordpress.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-wordpress) |

## Documentation

http://beetbox.readthedocs.io/en/latest/

## Contributing

http://beetbox.readthedocs.io/en/latest/contributing/contributing/

## Support

* Feature requests should be created in the [GitHub Beetbox Issue Queue](https://github.com/beetboxvm/beetbox/issues).
* Bugs should be reported in the [GitHub Beetbox Issue Queue](https://github.com/beetboxvm/beetbox/issues).
* Use pull requests (PRs) to [contribute](http://beetbox.readthedocs.io/en/latest/contributing/contributing/) to Beetbox.

## Credits
This project would not be possible without [geerlingguy's](https://github.com/geerlingguy) awesome Ansible roles from [Drupal VM](https://github.com/geerlingguy/drupal-vm).
We encourage you to support him by buying his book [Ansible for DevOps](http://ansiblefordevops.com/).

[JetBrains](https://www.jetbrains.com/phpstorm/) generously offer an Open source licence.

Beetbox is primarily maintained by the Drupal Melbourne (Australia) community.

Please follow [@beetboxvm](https://twitter.com/beetboxvm) for announcements.

## License

This project is licensed under the [MIT](https://opensource.org/licenses/MIT) open source license.
