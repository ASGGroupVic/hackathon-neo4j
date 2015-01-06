# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.network "forwarded_port", guest: 7474, host: 7474
  config.vm.network "forwarded_port", guest: 22222, host: 22222
  config.vm.network "forwarded_port", guest: 8080, host: 8080

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

  config.vm.provider :aws do |aws, override|
    #config.vm.box = "dummy"
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRECT_ACCESS_KEY']
    #aws.security_groups = ["sg-4929de2c"]
    aws.keypair_name = "Hackathon2"
    aws.instance_type = "m3.medium"
#   Removed this as it creates new Elastic Block Storage volume on every run
#    aws.block_device_mapping =    [  {
#       'DeviceName'              => '/dev/sdf',
#       'VirtualName'             => 'data',
#       'Ebs.VolumeSize'          => 10
#     }]
    aws.region = "ap-southeast-2"
    aws.ami = "ami-2def8d17"
    aws.tags = {
      'Name' => 'Hackathon-Neo4j',
    }
    override.vm.box = "dummy"
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "Hackathon2.pem"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Downloading EC2 api tools..."
    curl "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip" -o "ec2-api-tools.zip"
    sudo mkdir -p /usr/local/ec2
    unzip -o ec2-api-tools.zip -d /usr/local/ec2
    export EC2_HOME="/usr/local/ec2/ec2-api-tools-1.7.2.4"
    export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
    rm ec2-api-tools.zip
    #echo export PATH=/usr/local/ec2/ec2-api-tools-1.7.2.4/bin:$PATH >> ~/.bashrc
    #source ~/.bashrc
    instance=$($EC2_HOME/bin/ec2-describe-instances --aws-access-key #{ENV['AWS_ACCESS_KEY']} --aws-secret-key #{ENV['AWS_SECRECT_ACCESS_KEY']} --region ap-southeast-2 --filter 'tag:Name=Hackathon-Neo4j' --filter 'instance-state-name=running' | grep INSTANCE | awk {'print $2'})
    volume=$($EC2_HOME/bin/ec2-describe-volumes -aws-access-key #{ENV['AWS_ACCESS_KEY']} --aws-secret-key #{ENV['AWS_SECRECT_ACCESS_KEY']} --region ap-southeast-2 --filter 'tag:Name=xray 2b' | grep VOLUME |  awk {'print $2'})
    echo "Attaching EBS..."
    $EC2_HOME/bin/ec2-attach-volume -aws-access-key #{ENV['AWS_ACCESS_KEY']}  --aws-secret-key #{ENV['AWS_SECRECT_ACCESS_KEY']} "$volume" --instance "$instance" --device "/dev/sdf" --region ap-southeast-2
    sudo mkdir -p /data
    sudo echo /dev/xvdf  /data  auto  defaults,nobootwait,comment=neo4j 0 0 | sudo tee /etc/fstab
  SHELL

  config.vm.provision "docker" do |d|
    d.build_image "/vagrant_data/config/neo4j",
      args:   "-t smsmt/xray-neo4j"

    d.run "smsmt/xray-neo4j",
      daemonize: true,
      args:   "--name neo4j -p 7474:7474 -p 22222:22 -v /data:/data"
  end

  config.vm.provision "docker" do |d|
    d.build_image "/vagrant_data/config/api",
      args:   "-t smsmt/xray-api"

    d.run "smsmt/xray-api",
      daemonize: true,
      args:   "--name api -p 8080:8080"
  end

end
