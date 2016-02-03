# Simple

You can use beetbox with a default Vagrantfile as beetbox contains a Vagrantfile for basic functionality. 
Warning: Only use this method if you are 100% sure you won’t require customisation to your project Vagrantfile and it’s **not** recommended to add a default Vagrantfile to version control.

# Recommended

Download the project [Vagrantfile](https://raw.githubusercontent.com/drupalmel/beetbox/master/Vagrantfile) to the root of your project.

You can customise this as required for your project but please don’t remove any default functionality as this could break beetbox functionality. 

There’s no need to keep this up to date with the latest version, you only need to merge upstream updates to resolve issues the latest version may have fixed. It is highly recommended that you use version control as it allows other developers involved in the project to check out the code, run vagrant up, and be on their way.

You are free to implement plugins and improvements to vagrant as required for your project  using the [Vagrantfile docs](https://www.vagrantup.com/docs/vagrantfile/) for reference, please consider pushing improvements back to the project for the benefit of the beetbox community. - https://github.com/drupalmel/beetbox/pulls

# Advanced

You can maintain your own fork of our default [Vagrantfile](https://raw.githubusercontent.com/drupalmel/beetbox/master/Vagrantfile) which includes your own personal vagrant preferences which you can apply to new projects. Again please consider pushing improvements back to the project for the benefit of the beetbox community.