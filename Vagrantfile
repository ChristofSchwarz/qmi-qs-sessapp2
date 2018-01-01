# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.2"

require 'json'
require File.dirname(__FILE__)+'/../../shared-content/scripts/custom-setup.rb'

scenario = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'scenario.json')))
vals = CustomSetup.getValues( scenario )["servers"][0]

Vagrant.configure("2") do |config|
    config.vm.define vals["name"]
    config.vm.box = vals["box"]

    config.vm.network "private_network", ip: vals["ip"]

    config.vm.provider :virtualbox do |v, override|
        v.name = vals["name"]
        v.linked_clone = true
        v.customize ["modifyvm", :id, "--memory", vals["memory"]]
        v.customize ["modifyvm", :id, "--cpus", vals["cpus"]]
        v.customize ["modifyvm", :id, "--vram", 99]
        v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]

    end
    config.vm.hostname = vals["name"]
    config.vm.synced_folder "./files", "c:/installation/"
    config.vm.synced_folder "../../shared-content", "c:/shared-content/"
    config.vm.provision :shell, path: "../../shared-content/scripts/modules/q-background.ps1", :powershell_elevated_interactive => true
    config.vm.provision :shell, path: "./scripts/provisioner.ps1"


end
