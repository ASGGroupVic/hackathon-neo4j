# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "parallels/ubuntu-14.04"
  config.vm.network "forwarded_port", guest: 7474, host: 7474

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "parallels" do |v|
    v.name = "Hackathon-Ubuntu"
    v.check_guest_tools = false
    v.update_guest_tools = true
    v.optimize_power_consumption = false
    v.memory = 1024
    v.cpus = 2
  end

  # ensure puppet is installed
  config.vm.provision :shell, :path => "scripts/ubuntu.sh"

  # install r10k and dependencies
  config.vm.provision "shell", inline: <<-SHELL
    echo "Installing git..."
    sudo apt-get -y install git >/dev/null
    echo "Installing r10k..."
    gem install r10k >/dev/null
    cd /vagrant/puppet
    echo "r10k installing puppet modules..."
    sudo r10k puppetfile install
  SHELL

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = ["puppet/modules-contrib","puppet/modules-custom"]
    puppet.manifest_file = "site.pp"
    puppet.options = "--verbose --debug"
  end

end
