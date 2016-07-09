# Vagrantfile.local

The `Vagrantfile.local` can be used to override any default Vagrantfile configuration.

This can be stored in the root of the project or inside the `/.beetbox` directory.

The example below mounts the `.beetbox` directory to the home directory of the VM.

```
Vagrant.configure("2") do |config|

  config.vm.define "beetbox" do |beetbox|
    
    beetbox.vm.synced_folder "/.beetbox", "/home/vagrant/.beetbox",
      type: "nfs",
      id: "conf"
    
  end
  
end
```

This adds a new mounted directory but you could also override the default mount location or configuration.

```
Vagrant.configure("2") do |config|

  config.vm.define "beetbox" do |beetbox|
    
    beetbox.vm.synced_folder ".", "/var/beetbox",
      type: "rsync",
      id: "beetbox"
    
  end
  
end
```
