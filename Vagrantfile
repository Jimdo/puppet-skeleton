# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'skeleton-ubuntu'

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'init.pp'
    puppet.options = '--verbose --debug'
  end
end
