# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = 'jimdo-debian-6.0.7'
  config.vm.box_url = 'https://jimdo-vagrant-boxes.s3.amazonaws.com/jimdo-debian-6.0.7.box'
  config.vm.host_name = 'skeleton-debian'

  # TODO: do this using the apt puppet module
  # config.vm.provision :shell, :inline => 'apt-get update'

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'init.pp'
    puppet.options = '--verbose --debug'
  end
end
