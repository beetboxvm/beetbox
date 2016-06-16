# Configuration.

All customisation is done via a YAML configuration file at `.beetbox/config.yml`. If this file doesn't exist, it is automatically created the first time you start up the VM.

Configuration is applied hierarchically so any attribute set in your project config file will override a lower level default setting.

## Configuration from used roles
Each ansible role beetbox uses has a set of defaults (eg. the PHP role  https://github.com/geerlingguy/ansible-role-php/blob/master/defaults/main.yml)
so any of these YAML attributes could be imported into your project `config.yml` to override the default setting:
```
php_date_timezone: "Antarctica/South_Pole"
```

The full list of ansible roles beetbox implements is here: [https://github.com/beetboxvm/beetbox/blob/master/provisioning/ansible/config/beetbox.config.yml#L29](https://github.com/beetboxvm/beetbox/blob/master/provisioning/ansible/config/beetbox.config.yml#L29)

Beetbox itself has a predefined set of configuration: https://github.com/beetboxvm/beetbox/blob/master/provisioning/ansible/beetbox.config.yml
so not all attributes are defined inside roles and in some cases role attributes have already been overridden, however your project config will **always** override these settings.

When overriding complex values, such as lists, it is necessarry to include all values; i.e. there is no merging of overidden and default values.
