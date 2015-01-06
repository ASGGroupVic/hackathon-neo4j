hackathon-neo4j
===============

A demo project to bootstrap a Neo4j environment using Vagrant, Puppet and Docker. Requires Parallels or Virtualbox virtualisation software.

##Instructions

* To provision an AWS instance, copy the following command and run from the root of the repository folder (subtituting the place holders for your AWS access keys):
AWS_ACCESS_KEY = "[Your AWS access key]" AWS_SECRET_ACCESS_KEY = "[Your AWS secret access key]" vagrant up --provider aws
