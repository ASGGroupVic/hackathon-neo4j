hackathon-neo4j
===============

A demo project to bootstrap a Neo4j environment using Vagrant, Puppet and Docker. Requires Parallels or Virtualbox virtualisation software.

##Instructions

* To provision an AWS instance, copy the following command and run from the root of the repository folder (subtituting the place holders for your AWS access keys):
AWS_ACCESS_KEY = "[Your AWS access key]" AWS_SECRET_ACCESS_KEY = "[Your AWS secret access key]" vagrant up --provider aws

* You will need to install the Vagrant AWS plugin if you plan to provision to AWS.

##AWS vagrant plugin Note

*Problem* 
Error when deploying to AWS using plugin version 0.6.0 (latest at the time) you recieve the following error:
No host IP was given to the Vagrant core NFS helper. This is an internal error that should be reported as a bug. 

*Solution*  
Install the vagrant-aws plugin version 0.5.0 with the following command:
vagrant plugin install vagrant-aws --plugin-version 0.5.0 

For more information see the issue here:
https://github.com/mitchellh/vagrant-aws/issues/331
