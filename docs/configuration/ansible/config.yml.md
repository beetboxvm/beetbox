# config.yml

This is the main method to customise the VM.

In this file you can override any ansible variables provided by beetbox or by the galaxy roles.


# Common overrides.

  `vagrant_ip`
  
The IP of the VM, by default this is `0.0.0.0` and the auto network plugin will auto assign an IP.

  `vagrant_memory`
  
The memory given to the VM.

  `beet_project` (string)
  
The beetbox project role to invoke, by default this is drupal but you can also set this to `custom` to skip any project specific role.

  `beet_domain` (string)
  
The main domain name of the VM, it's also reused as a base for many other variables like the VM name etc.

  `beet_aliases` (list)
  
Addtional domains for the VM.

  `beet_base` (string)
  
The location which the root of the project is mounted to inside the VM, we don't recommend changing this location as it also requires setting an environment variable `BEET_BASE` so the config directory can be found.
 
  `beet_root` (string)
  
The root of the project, in some cases this might not be the same as the root of the repo.
If your docroot was at `/docroot` inside the repo you would add `beet_root: "{{ beet_base }}/docroot"`

  `beet_web` (string)
  
In some cases the web root is not the same as the project root or the root of the repo so you can override this to be the default docroot for apache. 
  

See the beetbox.config.yml for a full list of variables.
And each role can include their own specific variables, see the list of rles for more info.


# local.config.yml

This file will override `config.yml` and is usually excluded from the VCS so you can test or add specific override to the local instance.

This could include increasing the memory for the VM on a machine with lots of memory available.
