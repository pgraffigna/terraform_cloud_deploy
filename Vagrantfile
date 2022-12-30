ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
IMAGEN = "generic/ubuntu2004"
HOSTNAME = "deployer.cultura.lab"
RSYNC_PATH = "/home/vagrant"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder ".", RSYNC_PATH, type: "rsync", disabled: true

  config.vm.define :server do |s|
    s.vm.box = IMAGEN
    s.vm.hostname = HOSTNAME
    s.vm.box_check_update = false
    s.vm.provision "shell", path: "00-terra_install.sh"

    s.vm.provider :libvirt do |v|
      v.memory = 1024
      v.cpus = 2
    end
  end
end
