# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = 'jimdo-debian-7.5.0'
  config.vm.box_url = 'https://jimdo-vagrant-boxes.s3.amazonaws.com/jimdo-debian-7.5.0.box'
  config.vm.host_name = 'skeleton-debian'

  puppet_version = "3.7.0-1puppetlabs1"
  config.vm.provision :shell, :inline => "curl -Ls https://raw.githubusercontent.com/Jimdo/puppet-installer/master/puppet-installer.sh | bash -s -- -v #{puppet_version}"

  config.vm.provision :puppet do |puppet|
    puppet.module_path    = ENV.fetch('MODULES_PATH', nil)
    puppet.manifests_path = ENV.fetch('MANIFESTS_PATH', 'manifests')
    puppet.manifest_file  = ENV.fetch('MANIFEST_FILE', 'init.pp')
    puppet.options        = '--verbose --debug'
  end
end
