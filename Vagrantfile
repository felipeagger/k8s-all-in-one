Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.hostname = "master-k8s"

  config.vm.network "forwarded_port", guest: 443, host: 443, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 30800, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine using a specific IP.
  #config.vm.network "public_network"
  config.vm.network "private_network", ip: "192.168.1.10"

  #config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
      vb.name = "k8s-all-in-one"
      vb.cpus = "4"
      vb.memory = "4096"
  end
  
  # Disable selinux
  config.vm.provision "shell", inline: "setenforce 0"
  $script = <<-'SCRIPT'
    setenforce 0
    sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
  SCRIPT
  config.vm.provision "shell", inline: $script
  

  # Disable swap
  config.vm.provision "shell", inline: "swapoff -a"
  $script = <<-'SCRIPT'
    swapoff -a
    sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
  SCRIPT
  config.vm.provision "shell", inline: $script

  #Primeira Vez
  config.vm.provision :shell, privileged: true, path: "configEnv.sh"

  #Sempre ao Iniciar
  config.vm.provision :shell, privileged: true, run: "always", path: "startEnv.sh"

end