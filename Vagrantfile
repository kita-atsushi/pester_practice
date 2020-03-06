# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true

    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
    apt-get update
    dpkg -i packages-microsoft-prod.deb
    add-apt-repository universe
    apt-get update
    apt-get install -y powershell
    pwsh -Command "Install-Module -Name Pester -Force -PassThru"
    pwsh -Command "Install-Module -Name Az -AllowClobber -Scope AllUsers -Force -PassThru"
    pwsh -Command "Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'"
  SHELL
end
