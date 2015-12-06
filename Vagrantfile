# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.require_version '>= 1.7.4'

dir = File.dirname(File.expand_path(__FILE__))
vagrant_config = "#{dir}/config.yml"

if !File.exist?(vagrant_config)
  raise 'Vagrant configuration file config.yml not found!'
end

vconfig = YAML::load_file(vagrant_config)

Vagrant.configure("2") do |config|

  hostname = vconfig['drupal_domain']
  config.vm.box = "DrupalMel/beetbox"
  config.vm.hostname = hostname
  config.vm.network :private_network, ip: vconfig['vagrant_ip']
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  # Synced folders.
  config.vm.synced_folder ".", "/drupal",
    type: "nfs",
    id: "drupal"

  if vconfig['ansible_debug']
    config.vm.synced_folder "./ansible", "/beetbox/ansible",
      type: "nfs",
      id: "ansible"
    debug_mode = "BEETBOX_DEBUG=1"
  end

  # Upload vagrant.config.yml
  config.vm.provision "vagrant_config", type: "file" do |s|
   s.source = vagrant_config
   s.destination = "/beetbox/ansible/vagrant.config.yml"
  end

  # Upload local.config.yml
  local_config = "#{dir}/local.config.yml"
  if File.exist?(local_config)
    config.vm.provision "local_config", type: "file" do |s|
     s.source = local_config
     s.destination = "/beetbox/ansible/local.config.yml"
    end
  end

  # Provision box
  config.vm.provision "ansible", type: "shell" do |s|
    s.privileged = true
    s.inline = "#{debug_mode} chmod +x /beetbox/ansible/build.sh && /beetbox/ansible/build.sh"
  end

  # VirtualBox.
  config.vm.provider :virtualbox do |v|
    v.name = hostname
    v.memory = vconfig['vagrant_memory']
    v.cpus = vconfig['vagrant_cpus']
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Create local drush alias.
  if File.directory?("#{Dir.home}/.drush")

    alias_file = "#{Dir.home}/.drush/"+hostname+".aliases.drushrc.php"
    if ARGV[0] == "destroy"
      File.delete(alias_file) if File.exist?(alias_file)
    else
      require 'erb'
      class DrushAlias
        attr_accessor :hostname, :uri, :ip, :key, :root
        def template_binding
          binding
        end
      end

      template = <<ALIAS
<?php

$aliases['<%= @hostname %>'] = array(
   'uri' => '<%= @uri %>',
   'remote-host' => '<%= @ip %>',
   'remote-user' => 'vagrant',
   'ssh-options' => '-i <%= @key %> -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no',
   'root' => '<%= @root %>',
);
ALIAS

      alias_file = File.open(alias_file, "w+")
      da = DrushAlias.new
      da.hostname = hostname
      da.uri = hostname
      da.ip = vconfig['vagrant_ip']
      da.key = "#{Dir.home}/.vagrant.d/insecure_private_key"
      da.root = "/drupal/docroot"
      alias_file << ERB.new(template).result(da.template_binding)
      alias_file.close
    end
  end

end
