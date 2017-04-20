# Custom playbook.

With a custom playbook you're able to specifically define the roles / tasks for your project.

You first need to set `beet_provision_playbook` to the name of your custom playbook.

eg. setting `beet_provision_playbook: build` means you would have a playbook named `playbook-build.yml` in `/.beetbox/playbooks`.

Any playbooks in `/.beetbox/playbooks` are autoloaded during provisioning so you can have multiple then call them by setting a environment variable.

eg. `BEET_PLAY=custom vagrant provision` would run the playbook @ `/.beetbox/playbooks/playbook-custom.yml`

## Notes

We would recommend starting with our default [provisioning playbook](https://raw.githubusercontent.com/beetboxvm/beetbox/master/provisioning/ansible/playbook-provision.yml) and customising it.

You can find more info on playbooks here -- http://docs.ansible.com/ansible/playbooks.html
