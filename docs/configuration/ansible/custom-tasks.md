# Custom tasks.

Custom tasks are an easy way to extend beetbox by adding your own ansible tasks - http://docs.ansible.com/ansible/playbooks_intro.html#tasks-list

Tasks are automatically included in the beetbox play before (pre) and after (post) the main provisioning tasks.

## pre tasks

  `/.beetbox/tasks/pre/...`
  
Include task files in this directory to run before provisioning, for example if you want to install all project composer dependencies you could add the following

```
---
- name: Install project dependencies with composer.
  composer:
    command: install
    working_dir: "{{ beet_base }}"
  become: no

```

to a file `/.beetbox/tasks/pre/composer.yml`.

Tasks are run in alphabetical order if you have tasks dependencies and have access to all ansible variables within the scope of the project.

## post tasks

`/.beetbox/tasks/post/...`

Similar to pre tasks however these are run after the main playbook tasks.
 
## Notes

Please try to make these tasks idempotent so it doesn't delay provisioning when rerun.
