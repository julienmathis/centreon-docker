# coding: utf-8
Vagrant.configure("2") do |config|

 config.vm.box = "minimum/centos-7-docker"
 config.hostmanager.enabled = true
 node_number = 1

 config.vm.provider "virtualbox" do |v|
   v.cpus = 2
   v.memory = 2048
 end

 # Configuration du proxy sur les VMs vagrant
 if Vagrant.has_plugin?("vagrant-proxyconf")
   if ENV.has_key?('HTTP_PROXY') and ENV.has_key?('HTTPS_PROXY')
	 config.proxy.http     = "#{ENV['HTTP_PROXY']}"
	 config.proxy.https    = "#{ENV['HTTPS_PROXY']}"
	 config.proxy.no_proxy = "localhost,192.168.59.*,192.168.56.*,172.17.177.*,192.168.99.*,groupinfra.com"
   end
 end

   config.vm.define "centreon-docker" do |machine|
     machine.vm.hostname = "centreon-docker"
     machine.vm.synced_folder ".", "/centreon-central", type: "virtualbox"
     machine.vm.network "private_network", ip: "172.17.177.90"
	 
		# Enable provisioning with a shell script. Additional provisioners such as
		# Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
		# documentation for more information about their specific syntax and use.
	config.vm.provision "shell", inline: <<-SHELL
		yum update update
		yum install -y git
	SHELL
 end
end
