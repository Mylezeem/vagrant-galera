# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.vm.box = "puppetlabs-centos7"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  if Vagrant.has_plugin?("vagrant-r10k")
    config.r10k.puppet_dir = '.'
    config.r10k.puppetfile_path = 'Puppetfile'
  end

  config.vm.define "mysql01" do |mysql01|
    mysql01.vm.hostname = "mysql01.puppeels.mylezeem.com"

    mysql01.vm.synced_folder ".", "/vagrant", type: "rsync"
    mysql01.vm.provision "shell", inline: "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
    mysql01.vm.provision "shell", inline: "sed -i 's/^127/#127/' /etc/hosts"
    mysql01.vm.provision "shell", inline: "yum -y install http://mirrors.ircam.fr/pub/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
    mysql01.vm.provision "shell", inline: "yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm"
    mysql01.vm.provision "shell", inline: "yum -y install puppetlabs-release puppet"
    mysql01.vm.provision "shell", inline: "systemctl stop firewalld"

    mysql01.vm.provision "puppet" do |puppet|
      puppet.synced_folder_type = 'rsync'
      puppet.module_path = 'modules'
      puppet.hiera_config_path = 'hiera.yaml'
    end
  end

  config.vm.define "mysql02" do |mysql02|
    mysql02.vm.hostname = "mysql02.puppeels.mylezeem.com"

    mysql02.vm.synced_folder ".", "/vagrant", type: "rsync"
    mysql02.vm.provision "shell", inline: "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
    mysql02.vm.provision "shell", inline: "sed -i 's/^127/#127/' /etc/hosts"
    mysql02.vm.provision "shell", inline: "yum -y install http://mirrors.ircam.fr/pub/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
    mysql02.vm.provision "shell", inline: "yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm"
    mysql02.vm.provision "shell", inline: "yum -y install puppetlabs-release puppet"
    mysql02.vm.provision "shell", inline: "systemctl stop firewalld"

    mysql02.vm.provision "puppet" do |puppet|
      puppet.synced_folder_type = 'rsync'
      puppet.module_path = 'modules'
      puppet.hiera_config_path = 'hiera.yaml'
    end
  end

  config.vm.define "mysql03" do |mysql03|
    mysql03.vm.hostname = "mysql03.puppeels.mylezeem.com"

    mysql03.vm.synced_folder ".", "/vagrant", type: "rsync"
    mysql03.vm.provision "shell", inline: "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
    mysql03.vm.provision "shell", inline: "sed -i 's/^127/#127/' /etc/hosts"
    mysql03.vm.provision "shell", inline: "yum -y install http://mirrors.ircam.fr/pub/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
    mysql03.vm.provision "shell", inline: "yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm"
    mysql03.vm.provision "shell", inline: "yum -y install puppetlabs-release puppet"
    mysql03.vm.provision "shell", inline: "systemctl stop firewalld"

    mysql03.vm.provision "puppet" do |puppet|
      puppet.synced_folder_type = 'rsync'
      puppet.module_path = 'modules'
      puppet.hiera_config_path = 'hiera.yaml'
    end
  end

end
