# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.network "forwarded_port", guest: 7474, host: 7474

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./vagrant_data", "/vagrant_data"

  config.vm.provider "parallels" do |v|
    config.vm.box = "parallels/ubuntu-14.04"
    v.name = "Hackathon-Ubuntu"
    v.check_guest_tools = false
    v.update_guest_tools = true
    v.optimize_power_consumption = false
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.provider "virtualbox" do |v|
    config.vm.box = "ubuntu/trusty64"
    v.name = "Hackathon-Ubuntu"
    v.gui = true
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.provision "docker" do |d|
    d.build_image "/vagrant_data/config/neo4j",
      args: "-t smsmt/xray-neo4j"
    d.run "smsmt/xray-neo4j",
      daemonize: true,
      args:   "--interactive --tty --name neo4j --privileged --publish 7474:7474"
  end

end
