# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # TODO: build a squeeze64 box and use it here
  config.vm.box = 'jimdo-debian-6.0.7'
  config.vm.box_url = 'https://s3-eu-west-1.amazonaws.com/jimdo-vagrant-boxes/jimdo-debian-6.0.7.box'
  config.vm.host_name = 'skeleton-debian'

  # TODO: do this using the apt puppet module
  config.vm.provision :shell, :inline => 'apt-get update'

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'init.pp'
    puppet.options = '--verbose --debug'
  end
end
