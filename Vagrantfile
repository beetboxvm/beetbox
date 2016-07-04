# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['BEET_ROOT_DIR'] = "#{__dir__}"
ENV['BEET_CONFIG_DIR'] = ENV['BEET_CONFIG_DIR'] || "#{ENV['BEET_ROOT_DIR']}/.beetbox"
r_vagrantfile = ENV['BEET_VAGRANTFILE'] || "https://raw.githubusercontent.com/beetboxvm/beetbox/master/.beetbox/Vagrantfile"
l_vagrantfile = "#{ENV['BEET_CONFIG_DIR']}/Vagrantfile"

# Create local Vagrantfile.
if !File.exist?(l_vagrantfile)
  require 'fileutils'
  require 'open-uri'
  begin
    FileUtils::mkdir_p ENV['BEET_CONFIG_DIR']
    vfile = open(r_vagrantfile).read
  rescue
    raise "Can't access #{r_vagrantfile}."
  else
    f = open(l_vagrantfile, 'w+') << vfile
    f.close
  end
end

# load local Vagrantfile.
load l_vagrantfile
