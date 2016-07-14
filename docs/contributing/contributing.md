# Contributing

Contributing is easy, the hardest part is knowing which project to add your pull request to.

The main knowledge required is [Ansible](https://www.ansible.com/): it's pretty easy to pick up and they have some good docs available &mdash; http://docs.ansible.com/.

The main project Beetbox core (https://github.com/beetboxvm/beetbox) is essentially some plumbing to initiate a set of external roles hosted on [Ansible galaxy](https://galaxy.ansible.com).

We have a few internal ansible tasks, but these are only for low level setup and a few features like custom tasks and the welcome message you see at the end of provisioning.

# Setup

The first step to contributing is to bring up the example project:

```
git clone https://github.com/beetboxvm/beetbox && cd $_
vagrant up
```

This has been modified to use a debug mode which will:

- show more details when provisioning
- mount [`provisioning`](https://github.com/beetboxvm/beetbox/tree/master/provisioning) directory into the VM, so it's editable and changes could be picked up by `vagrant provision`
- checkout the ansible roles from their source repo, rather than from ansible galaxy

From this point you can modify anything inside the [`provisioning`](https://github.com/beetboxvm/beetbox/tree/master/provisioning) directory and apply changes with `vagrant provision`.

*Note: sometimes it's easier to disable (comment out) all roles when debugging, but be careful as there can be role dependencies.

# Forking the project

Please follow these instructions to fork the project: https://help.github.com/articles/fork-a-repo/

Next, you'll want to change you local repo to use the fork
```
git remote set-url origin [git URL of fork]
```

Now you should be able to branch and push changes to your fork of the project.
 
# Creating a PR

We use pull requests to accept changes to the project. There's already good docs for doing this on github: https://help.github.com/articles/using-pull-requests/

# Roles

If you find that the task/role you're updating isn't in the Beetbox core, this is because it is an external role.
You can still contribute to these, however they are separate projects.

The roles we implement are listed in [`/provisioning/ansible/config/beetbox.config.yml`](https://github.com/beetboxvm/beetbox/blob/master/provisioning/ansible/config/beetbox.config.yml#L33).

The same applies to forking and creating PR's for these roles too, however you'll want to point the role repo to your fork rather than the Beetbox project.

```
cd /path/to/role
git remote set-url origin [git URL of fork]
```

You can now commit and push changes to your fork for creating a PR on the external project.
