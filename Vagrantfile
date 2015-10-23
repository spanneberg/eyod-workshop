Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  
  config.vm.synced_folder "puppet", "/opt/puppet"

  config.vm.define "gitlab" do |gitlab|
    gitlab.vm.hostname = "gitlab.local"
    gitlab.vm.network "private_network", ip: "192.168.33.10"
    gitlab.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  (1..2).each do |i|
    config.vm.define "ci#{i}" do |node|
      node.vm.hostname = "ci#{i}.local"
      node.vm.network "private_network", ip: "192.168.33.#{20 + i}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
    end
  end

  # config.vm.provider "virtualbox" do |vb|
  #   vb.memory = "1024"
  # end

  config.vm.provision "shell", path: "scripts/bootstrap.sh"
  config.vm.provision "shell", path: "scripts/provision.sh"

  # config.vm.provision "puppet" do |puppet|
  #   puppet.options            = "--verbose"
  #   puppet.environment        = "dev"
  #   puppet.environment_path   = "puppet/environments"
  #   puppet.hiera_config_path  = "puppet/hiera.yaml"
  # end

end
