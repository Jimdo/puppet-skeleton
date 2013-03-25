# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # TODO: build a squeeze64 box and use it here
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'skeleton-ubuntu'

  # TODO: do this using the apt puppet module
  config.vm.provision :shell, :inline => 'apt-get update'

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'init.pp'
    puppet.options = '--verbose --debug'
  end
end
