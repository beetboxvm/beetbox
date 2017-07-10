# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require 'json'
require 'yaml'

Vagrant.require_version '>= 1.8.5'

beet_root = ENV['BEET_ROOT_DIR'] || "#{__dir__}"
config_dir = ENV['BEET_CONFIG_DIR'] || "#{beet_root}/.beetbox"
project_config = "#{config_dir}/config.yml"
local_config = "#{config_dir}/local.config.yml"
composer_conf = JSON.parse(ENV['COMPOSER'] || File.read("#{beet_root}/composer.json"))
vendor_dir = ENV['COMPOSER_VENDOR_DIR'] || composer_conf.fetch('config', {}).fetch('vendor-dir', 'vendor')
default_config = "#{beet_root}/#{vendor_dir}/beet/box/provisioning/ansible/config/default.config.yml"
default_config = "#{beet_root}/provisioning/ansible/config/default.config.yml" if !File.exist?(default_config)

# Default vagrant config.
vconfig = YAML::load_file(default_config)
vconfig['beet_domain'] = beet_root.split('/').last.gsub(/[\._]/, '-') + ".local"

# Create config directory.
FileUtils.mkdir_p config_dir

# Create config.yml from composer config.
cconfig = composer_conf['extra']['beetbox'] rescue nil
File.open(project_config, "w") { |f| f.write(cconfig.to_yaml) } if cconfig.is_a?(Hash)

# Create default config file.
default_config = "---\nbeet_domain: #{vconfig['beet_domain']}\n"
File.open(project_config, "w") { |f| f.write(default_config) } if !File.exist?(project_config)

# Copy config from host.
host_config = "#{Dir.home}/.beetbox/config.yml"
if File.exist?(host_config)
  FileUtils.cp(host_config, "#{config_dir}/host.config.yml")
end

pconfig = YAML::load_file(project_config) || nil
vconfig = vconfig.merge pconfig if !pconfig.nil?

# Merge local.config.yml
if File.exist?(local_config)
  lconfig = YAML::load_file(local_config) || nil
  vconfig = vconfig.merge lconfig if !lconfig.nil?
end

# Replace variables in YAML config.
vconfig.each do |key, value|
  while vconfig[key].is_a?(String) && vconfig[key].match(/{{ .* }}/)
    vconfig[key] = vconfig[key].gsub(/{{ (.*?) }}/) { |match| match = vconfig[$1] }
  end
end

hostname = vconfig['beet_domain']
branches = ['beetbox']
current_branch = 'beetbox'

Vagrant.configure("2") do |config|

  # Hosts file plugins.
  if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.aliases = vconfig['beet_aliases']
  elsif Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = vconfig['beet_aliases']
  end

  # Multidev config.
  if vconfig['beet_mode'] == 'multidev'
    branches = %x(git branch | tr -d '* ').split(/\n/).reject(&:empty?)
    branches.unshift("beetbox")
    current_branch = %x(git branch | grep '*' | tr -d '* \n')
    vconfig['vagrant_ip'] = "0.0.0.0"
    branch_prefix = true
  end

  # Check for plugins and attempt to install if not (Windows only).
  if Vagrant::Util::Platform.windows?
    %x(vagrant plugin install vagrant-hostsupdater) unless Vagrant.has_plugin?('vagrant-hostsupdater')
    raise 'Your config requires hostsupdater plugin.' unless Vagrant.has_plugin?('vagrant-hostsupdater')
    if vconfig['vagrant_ip'] == "0.0.0.0"
      %x(vagrant plugin install vagrant-auto_network) unless Vagrant.has_plugin?('vagrant-auto_network')
      raise 'Your config requires auto_network plugin.' unless Vagrant.has_plugin?('vagrant-auto_network')
    end
  end

  # Vagrant Cachier config.
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
    config.cache.enable :generic, { "drush" => { cache_dir: "/home/vagrant/.drush/cache" }, }
    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  if Vagrant.has_plugin?('vagrant-exec')
    config.exec.commands "*", directory: "#{vconfig['beet_base']}"
  end

  branches.each do |branch|
    active_node = (branch == current_branch) ? true : false
    config.vm.define branch, autostart: active_node, primary: active_node do |node|

      node.vm.box = vconfig['vagrant_box']
      node.vm.box_version = vconfig['vagrant_box_version']
      node.vm.hostname = (branch_prefix) ? "#{branch}.#{hostname}" : hostname
      node.ssh.insert_key = false
      node.ssh.forward_agent = true

      # Network config.
      if vconfig['vagrant_ip'] == "0.0.0.0" && Vagrant.has_plugin?('vagrant-auto_network')
        node.vm.network :private_network, :ip => "0.0.0.0", :auto_network => true
      elsif vconfig['vagrant_ip'] == "0.0.0.0"
        node.vm.network :private_network, :type => "dhcp"
      else
        node.vm.network :private_network, ip: vconfig['vagrant_ip']
      end

      # Synced folders.
      node.vm.synced_folder ".", vconfig['beet_base'],
        type: "nfs",
        id: "beetbox"

      if vconfig['beet_debug']
        node.vm.synced_folder "./provisioning", "#{vconfig['beet_home']}/provisioning",
          type: "nfs",
          id: "debug"
        debug_mode = "BEET_DEBUG=true"
      end

      if vconfig['beet_provision']
        # Provision box
        beet_sh = "#{vconfig['beet_home']}/provisioning/beetbox.sh"
        beet_profile = ENV['BEET_PROFILE'] || "#{vconfig['beet_profile']}"
        beet_sh_playbook = ENV['BEET_PLAY'] || "#{vconfig['beet_provision_playbook']}"
        beet_sh_tags = ENV['BEET_TAGS'] || "#{vconfig['beet_provision_tags']}"
        local_provision = "sudo chmod +x #{beet_sh} && #{debug_mode} BEET_PROFILE=#{beet_profile} BEET_PLAYBOOK=#{beet_sh_playbook} BEET_TAGS=#{beet_sh_tags} #{beet_sh}"
        remote_provision = "sudo apt-get -y install curl && curl -fsSL http://bit.ly/beetbuild | bash -Ee"
        node.vm.provision "ansible", type: "shell" do |s|
          s.privileged = false
          s.inline = "if [ -f #{beet_sh} ]; then #{local_provision}; else #{remote_provision}; fi"
        end
      end

      # VirtualBox.
      node.vm.provider :virtualbox do |v|
        v.name = "#{node.vm.hostname}.#{Time.now.to_i}"
        v.memory = vconfig['vagrant_memory']
        v.cpus = vconfig['vagrant_cpus']
        v.linked_clone = true
        v.customize ["modifyvm", :id,
          "--natdnshostresolver1", "on",
          "--ioapic", "on",
          "--vrde", "off"
        ]
      end

      # VMware Fusion.
      config.vm.provider :vmware_fusion do |v, override|
        override.vm.box = "ubuntu/trusty64"
        v.gui = false
        v.vmx['memsize'] = vconfig['vagrant_memory']
        v.vmx['numvcpus'] = vconfig['vagrant_cpus']
      end

      # Parallels.
      config.vm.provider :parallels do |p, override|
        override.vm.box = "parallels/ubuntu-14.04"
        p.name = "#{node.vm.hostname}.#{Time.now.to_i}"
        p.memory = vconfig['vagrant_memory']
        p.cpus = vconfig['vagrant_cpus']
        p.update_guest_tools = true
      end

    end
  end
end

# Create local drush alias.
if vconfig['drush_create_alias'] && vconfig['beet_project'] == 'drupal' && File.directory?("#{Dir.home}/.drush")

  alias_file = vconfig['drush_alias_file'] || "#{Dir.home}/.drush/"+hostname+".aliases.drushrc.php"
  alias_file = "#{project_root}/#{vconfig['drush_alias_file']}" if vconfig['drush_alias_file']

  if ARGV[0] == "destroy"
    File.delete(alias_file) if File.exist?(alias_file)
  else
    require 'erb'
    class DrushAlias
      attr_accessor :hostname, :uri, :key, :root
      def template_binding
        binding
      end
    end

    template = <<ALIAS
<?php

$aliases['<%= @hostname %>'] = array(
   'uri' => '<%= @uri %>',
   'remote-host' => '<%= @uri %>',
   'remote-user' => 'vagrant',
   'ssh-options' => '-i <%= @key %> -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no',
   'root' => '<%= @root %>',
);
ALIAS

    alias_file = File.open(alias_file, "w+")
    da = DrushAlias.new
    da.hostname = vconfig['drush_alias_name'] || hostname
    da.uri = hostname
    da.key = "#{Dir.home}/.vagrant.d/insecure_private_key"
    da.root = vconfig['beet_web'] ||= vconfig['beet_root'] ||= vconfig['beet_base']
    alias_file << ERB.new(template).result(da.template_binding)
    alias_file.close
  end
end

# Load local Vagrantfile, if exists.
include_vagrantfile_root = "#{beet_root}/Vagrantfile.local"
load include_vagrantfile_root if File.exist?(include_vagrantfile_root)
include_vagrantfile_conf = "#{config_dir}/Vagrantfile.local"
load include_vagrantfile_conf if File.exist?(include_vagrantfile_conf)
