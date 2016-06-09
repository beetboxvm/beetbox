# load beetbox Vagrantfile.
require 'open-uri'

ENV['BEET_CONFIG_DIR'] = ENV['BEET_CONFIG_DIR'] || "#{__dir__}/.beetbox"
r_vagrantfile = "https://raw.githubusercontent.com/beetboxvm/beetbox/master/.beetbox/Vagrantfile"
l_vagrantfile = "#{ENV['BEET_CONFIG_DIR']}/Vagrantfile"

load l_vagrantfile if File.exist?(l_vagrantfile)

# Create local Vagrantfile
if !File.exist?(l_vagrantfile)
  require 'fileutils'
  FileUtils::mkdir_p ENV['BEET_CONFIG_DIR']
  open(l_vagrantfile, 'w+') << vagrantfile = open(r_vagrantfile).read
  eval(vagrantfile)
end
