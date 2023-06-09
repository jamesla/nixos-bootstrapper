# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "nixos"
  config.vm.hostname = "carverlinux"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  # ssh key
  config.vm.provision 'file', source: "#{Dir.home}/.ssh/id_rsa", destination: "~/.ssh/id_rsa"
  config.vm.provision 'shell', privileged: false, inline: 'chmod 600 ~/.ssh/id_rsa'

  config.vm.provision "file", source: "nixos", destination: "$HOME/nixos"

  #provision
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    echo -e "vagrant\nvagrant" | sudo passwd vagrant
    cd nixos
    make parallels
  SHELL

  config.vm.provider 'parallels' do |prl|
    prl.name = config.vm.hostname
    prl.memory = 12000
    prl.cpus = 4
    prl.update_guest_tools = false
    # we do want this but it's bugged and causes machine to bluescreen
    # try in a few parallels or something
    # prl.linked_clone = false

    prl.customize ['set', :id, '--startup-view=fullscreen']
    prl.customize ['set', :id, '--device-set=net0', '--adapter-type=e1000']
    prl.customize ['set', :id, '--nested-virt', 'on']
    prl.customize ['set', :id, '--videosize', '64']
  end

end
