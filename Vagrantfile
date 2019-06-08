Vagrant.configure("2") do |config|
  
  config.vm.define "db01" do |node|
    node.vm.box = "berchev/redis64"
    node.vm.hostname = "db01"
    node.vm.network "private_network", ip: "192.168.56.11"
    node.vm.provision :shell, path: "scripts/db01_provision.sh"
  end 

  config.vm.define "vault" do |node|
    node.vm.box = "berchev/xenial64"
    node.vm.hostname = "vault"
    node.vm.network "private_network", ip: "192.168.56.31"
    node.vm.network :forwarded_port, guest: 8200, host: 8200
    node.vm.provision :shell, path: "scripts/vault_provision.sh"
  end

  config.vm.define "app01" do |node|
    node.vm.box = "berchev/xenial64"
    node.vm.hostname = "app01"
    node.vm.network "private_network", ip: "192.168.56.21"
    node.vm.provision :shell, path: "scripts/app01_provision.sh"
  end
  
end
