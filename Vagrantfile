# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", ip: "192.168.50.6"
    config.vm.hostname = "nodejs.vg.com"
    config.vm.synced_folder "public/", "/var/www/html",disabled: false, :mount_options => ["dmode=777", "fmode=666"]
    config.vm.provision :shell, :path => "settings/provision/bootstrap.sh"
    config.vm.provider "virtualbox" do |v|
     v.memory = 2048
     v.name = "big-commerce"
     v.cpus = 2
    end
end
