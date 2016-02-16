# Configuration.

All customisation is done via a YAML configuration file at `.beetbox/config.yml`. If this file doesn't exist, it is automatically created the first time you start up the VM.

Configuration is applied hierarchically so any attribute set in your project config file will override a lower level default setting.

## Configuration from used roles
Each ansible role beetbox uses has a set of defaults (eg. the PHP role  https://github.com/geerlingguy/ansible-role-php/blob/master/defaults/main.yml)
so any of these YAML attributes could be imported into your project `config.yml` to override the default setting:
```
php_date_timezone: "Antarctica/South_Pole"
```

The full list of ansible roles beetbox implements is here: [https://github.com/drupalmel/beetbox/blob/master/provisioning/ansible/beetbox.config.yml#L29](https://github.com/drupalmel/beetbox/blob/master/provisioning/ansible/beetbox.config.yml#L29)

Beetbox itself has a predefined set of configuration: https://github.com/drupalmel/beetbox/blob/master/provisioning/ansible/beetbox.config.yml
so not all attributes are defined inside roles and in some cases role attributes have already been overridden, however your project config will **always** override these settings.

When overriding complex values, such as lists, it is necessarry to include all values; i.e. there is no merging of overidden and default values.

## Default configuration.

Beetbox
-----------------
Variable | Default  | Description
--------------------- | ---------     | ----------
`beet_repo`           | `https://github.com/DrupalMel/beetbox.git` | git project URL
`beet_version`        | `HEAD` | git project version
`beet_home`           | `/beetbox` | path to beetbox repo inside VM
`beet_role_dir`       | `/beetbox/ansible/roles` | path to ansible roles inside VM
`beet_project`        | `drupal` |
`beet_keep_updated`   | `no` | update beetbox repo inside VM before provisioning
`beet_debug`          | `no` | mount ansible directory inside VM for development
`beet_domain`         | `beetbox.local` | local domain for the VM
`beet_base`           | `/var/beetbox` | project mount point inside VM
`beet_root`           | `/var/beetbox` | path to project root insdie VM
`beet_web`            | `/var/beetbox` | path to docroot inside VM
`beet_ssh_home`       | `/var/beetbox` | entry point when using `vagrant ssh`
`beet_site_name`      | `Beetbox` | name of site, used for automatic installations
`beet_webserver`      | `apache` | webserver type
`beet_mysql_user`     | `beetbox` | mysql username
`beet_mysql_password` | `beetbox` | mysql password
`beet_mysql_database` | `beetbox` | mysql database name
