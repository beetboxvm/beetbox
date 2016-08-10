# Beetbox - a pre-provisioned L*MP stack

A VM for local L*MP development, built with Packer, Vagrant + Ansible

Beetbox is essentially a pre-provisioned version of [Drupal VM](http://www.drupalvm.com/) mainly to speed up initial build time, but also to reduce the size of each VM by leveraging [linked clones](https://www.hashicorp.com/blog/vagrant-1-8.html).

Whilst it contains a set of default features, it is extremely extensible and almost anything can be overridden/extended with a simple YAML config file.

It is designed to have an instance (VM) per project and be integrated into a VCS like git, so that configuration can be easily shared within a team and a setup of a new project should be as simple as `git clone ...; vagrant up`.

This particular project contains the plumbing to manage the automated build of the pre-provisioned Vagrant base box, so almost all functionality is provided by ansible roles external to this project.

[![Circle CI](https://circleci.com/gh/beetboxvm/beetbox.svg?style=shield)](https://circleci.com/gh/beetboxvm/beetbox) [![Documentation Status](https://readthedocs.org/projects/beetbox/badge/?version=stable)](http://beetbox.readthedocs.org/en/stable/?badge=stable)

## Why not use Drupal VM / Vlad?

* You only add config to your project and don't need to manage a fork of the whole provisioning system.
* It uses a pre-provisioned base box so it’s much faster to provision.
* Each new version of the box gets published to Atlas only if all roles are provisioned making the box always stable.
* With linked clones each VM is a small clone of a single master.
* You can reuse the same provisioning system for a CI environment.
* Minimal host machine dependencies.

## Requirements

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

Include this [Vagrantfile](https://raw.githubusercontent.com/beetboxvm/beetbox/master/Vagrantfile) in the root of your project (usually the one which contains `index.php`) and `vagrant up`.

This will automatically generate the `.beetbox` directory, which will contain a `config.yml` file used to configure overrides.

You can see some examples in [`config.yml`](https://github.com/beetboxvm/beetbox/blob/master/.beetbox/config.yml)

## Drupal Quickstart

To get a simple Drupal site up and running with Beetbox, run the following commands:

```
drush dl drupal-8.1.8 && cd $_
curl https://raw.githubusercontent.com/beetboxvm/beetbox/master/Vagrantfile > Vagrantfile
vagrant up
```

After which you can install the site at [http://drupal-8.1.8.local/install.php](http://drupal-8.1.8.local/install.php)

or add the following to `./beetbox/config.yml` and run `vagrant provision` to automatically install drupal:

```
drupal_install_site: yes
drupal_account_name: admin
drupal_account_pass: admin
```

For PHP 7 add `php_version: "7.0"` to `./beetbox/config.yml`, then run `vagrant provision`.

## Project roles.

These roles are mantained by Beetbox team.

| Project | Build status |
| --- | --- |
| [Backdrop](https://github.com/beetboxvm/ansible-role-beetbox-backdrop) | [![Circle CI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-backdrop.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-backdrop) |
| [CakePHP](https://github.com/beetboxvm/ansible-role-beetbox-cakephp) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-cakephp.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-cakephp) |
| [Concrete5](https://github.com/beetboxvm/ansible-role-beetbox-concrete5) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-concrete5.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-conc rete5) |
| [Drupal](https://github.com/beetboxvm/ansible-role-beetbox-drupal) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-drupal.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-drupal) |
| [Kohana](https://github.com/beetboxvm/ansible-role-beetbox-kohana) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-kohana.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-kohana) |
| [Modx](https://github.com/beetboxvm/ansible-role-beetbox-modx) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-modx.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-modx) |
| [Silverstripe](https://github.com/beetboxvm/ansible-role-beetbox-silverstripe) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-silverstripe.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-silverstripe) |
| [Slim](https://github.com/beetboxvm/ansible-role-beetbox-slim) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-slim.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-slim) |
| [Wordpress](https://github.com/beetboxvm/ansible-role-beetbox-wordpress) | [![CircleCI](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-wordpress.svg?style=shield)](https://circleci.com/gh/beetboxvm/ansible-role-beetbox-wordpress) |

## Documentation

http://beetbox.readthedocs.io/en/latest/

## Contributing

http://beetbox.readthedocs.io/en/latest/contributing/contributing/

## Support

* Feature requests should be created on [FeatHub](http://feathub.com/beetboxvm/beetbox).
* Bugs should be reported in the [GitHub Beetbox Issue Queue](https://github.com/beetboxvm/beetbox/issues).
* Use pull requests (PRs) to [contribute](http://beetbox.readthedocs.io/en/latest/contributing/contributing/) to Beetbox.

## Credits
This project would not be possible without [geerlingguy's](https://github.com/geerlingguy) awesome Ansible roles from [Drupal VM](https://github.com/geerlingguy/drupal-vm).
We encourage you to support him by buying his book [Ansible for DevOps](http://ansiblefordevops.com/).

Beetbox is primarily maintained by the Drupal Melbourne (Australia) community.

Please follow [@beetboxvm](https://twitter.com/beetboxvm) for announcements.

## License

This project is licensed under the [MIT](https://opensource.org/licenses/MIT) open source license.
