# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.ssh.forward_agent = true
    config.vm.box = "chef/centos-7.0"
    config.vm.hostname = "CentOS"

    config.vm.provider "virtualbox" do |v|
        v.gui = true
        v.memory = 4096
    end

    config.vm.synced_folder ".", "/vagrant", :nfs => { :mount_options => ["dmode=700","fmode=600"] }

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    if Vagrant::Util::Platform.windows?
        config.vm.provision "shell", path: "./bootstrap.sh"
        config.vm.define "centos" do |centos|
            centos.vm.network "private_network", ip: "192.168.99.10"
        end
    else
        config.vm.define "centos" do |centos|
            centos.vm.network "private_network", ip: "192.168.99.10"
        end

        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "playbook.yml"
            ansible.inventory_path = "hosts"
            ansible.limit = "vm"
        end
    end
end
