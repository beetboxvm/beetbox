# Recommended

Download the project [Vagrantfile](https://raw.githubusercontent.com/beetboxvm/beetbox/master/Vagrantfile) to the root of your project.

We recommend not tracking the delegated `Vagrantfile` as this is automatically downloaded when you first build the project.
To update to the latest version just delete `./beetbox/Vagrantfile` and run `vagrant status`. 

Vagrant overrides can be included in `/Vagrantfile.local` or `./beetbox/Vagrantfile.local`.

It is highly recommended that you add the root Vagrantfile to version control as it allows other developers involved in the project to check out the code, run vagrant up, and be on their way.

You are free to implement plugins and improvements to vagrant as required for your project using the [Vagrantfile docs](https://www.vagrantup.com/docs/vagrantfile/) for reference, please consider pushing improvements back to the project for the benefit of the beetbox community. - https://github.com/beetboxvm/beetbox/pulls

# Advanced

Replace [`r_vagrantfile`] (https://github.com/beetboxvm/beetbox/blob/master/Vagrantfile#L5) with a path to your own fork of our default [Vagrantfile](https://raw.githubusercontent.com/beetboxvm/beetbox/master/.beetbox/Vagrantfile), this can include your own personal vagrant preferences which you can apply to new projects. 
Again please consider pushing improvements back to the project for the benefit of the beetbox community.
