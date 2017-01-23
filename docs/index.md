# Beetbox - a pre-provisioned L*MP stack

## Requirements

* [Vagrant](https://www.vagrantup.com/) >= 1.8
* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)
* [Vagrant Auto-network](https://github.com/oscar-stack/vagrant-auto_network)


## Quickstart

```
composer require --dev beet/box
vagrant up
```

This will automatically generate a Vagrantfile and the `.beetbox` directory, which will contain a `config.yml` file used to configure overrides.

You can see some examples in [`config.yml`](https://github.com/beetboxvm/beetbox/blob/master/.beetbox/config.yml)

## Drupal Quickstart

To get a simple Drupal 8 site up and running with Beetbox, run the following commands:

```
drush pm-download drupal-8 --drupal-project-rename=drupal8 && cd drupal8
php -r "readfile('https://raw.githubusercontent.com/beetboxvm/beetbox/master/Vagrantfile');" > Vagrantfile
vagrant up
```

After which you can install the site at [http://drupal8.local/install.php](http://drupal8.local/install.php)

or add the following to `./beetbox/config.yml` and run `vagrant provision` to automatically install drupal.

```
drupal_install_site: yes
drupal_account_name: admin
drupal_account_pass: admin
```

For PHP 7 add `php_version: "7.0"` then `vagrant provision`
