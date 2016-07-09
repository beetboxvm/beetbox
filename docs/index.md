# Beetbox - a pre-provisioned L*MP stack

## Requirements

* [Vagrant](https://www.vagrantup.com/) >= 1.8
* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)
* [Vagrant Auto-network](https://github.com/oscar-stack/vagrant-auto_network)


## Quickstart

Include this [Vagrantfile](https://raw.githubusercontent.com/beetboxvm/beetbox/master/Vagrantfile) in the root of your project (usually the one which contains index.php) and `vagrant up`.
This will automatically generate the `.beetbox` directory which will contain a `config.yml` file used to configure overrides.
You can see some examples here - [`config.yml`](https://github.com/beetboxvm/beetbox/blob/master/.beetbox/config.yml)

## Drupal Quickstart

To get a simple Drupal site up and running with Beetbox, run the following commands:

```
drush dl drupal-8.1.2 && cd $_
wget https://raw.githubusercontent.com/beetboxvm/beetbox/master/Vagrantfile
vagrant up
```

After which you can install the site at [http://drupal-8.1.2.local/install.php](http://drupal-8.1.2.local/install.php)

or add the following to `./beetbox/config.yml` and run `vagrant provision` to automatically install drupal.

```
drupal_install_site: yes
drupal_account_name: admin
drupal_account_pass: admin
```

For PHP 7 add `php_version: "7.0"` then `vagrant provision`
