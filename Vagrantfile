# -*- mode: ruby -*-
# vi: set ft=ruby :
require_relative 'secrets'
include MyVars

Vagrant.configure("2") do |config|
  config.vm.define 'dev' do |dev|
    dev.vm.box = "precise64"
    dev.vm.box_url = "http://files.vagrantup.com/precise64.box"
    dev.vm.provision :shell,
      inline: "sudo -H -u vagrant /vagrant/setup_dev.sh -u"
    dev.vm.network "forwarded_port", guest: 8080, host: 8080
    dev.vm.network "forwarded_port", guest: 8081, host: 8081
    dev.vm.provider "virtualbox" do |v|
      v.name = "securedrop"
    end
  end

  config.vm.define 'mon' do |mon|
    mon.ssh.private_key_path = "~/.ssh/id_rsa"
    mon.vm.box = "trusty64"
    mon.vm.box_url = "http://files.vagrantup.com/trusty64.box"
  end

 config.vm.define 'app' do |app|
    app.ssh.private_key_path = "~/.ssh/id_rsa"
    app.vm.box = "trusty64"
    app.vm.box_url = "http://files.vagrantup.com/trusty64.box"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "install_files/ansible-base/secureDrop-server.yml"
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    provider.ssh_key_name = "dev-vps"
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    provider.token = TOKEN
    provider.image = "Ubuntu 14.04 x64"
    provider.region = "nyc2"
    provider.size = '512mb'
  end

  # "Quick Start" config from https://github.com/fgrehm/vagrant-cachier#quick-start
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end
