vm1 = { 'name' => "WinVM1" }
#, 'ip' => "10.10.10.90" }
vm2 = { 'name' => "WinVM2" }
#, 'ip' => "10.10.10.91" }
vms = [ vm1, vm2]
 
Vagrant.configure(2) do |config|
config.vm.synced_folder ".", "/vagrant", disabled: true
  vms.each do |node|
    vm_name = node['name']
    #vm_ip = node['ip']
    config.vm.define vm_name do |node_config|
        #node_config.vm.network 'private_network', type: "dhcp"
		node_config.vm.box = "dummy"
        node_config.vm.box_url = "dummy.box"
		node_config.vm.communicator = "winrm"
		node_config.vm.boot_timeout = 240
        node_config.vm.graceful_halt_timeout = 240
        node_config.winrm.timeout = 200
        node_config.winrm.username = "Administrator"
        node_config.winrm.password = "packer"
        node_config.winrm.transport = :plaintext
        node_config.winrm.basic_auth_only = true
		#node_config.vm.provision :restart
        
	node_config.vm.provider :vsphere do |vsphere|
        vsphere.host = 'vc01'
        vsphere.compute_resource_name = 'cluster'
        vsphere.name = vm_name
        vsphere.customization_spec_name = 'Windows'
        vsphere.template_name = 'packer-templates/Win2019_Packer'
        vsphere.user = 'vmuser'
        vsphere.password = 'vmpassword'
        vsphere.insecure = true
        end
        end
  end
end
