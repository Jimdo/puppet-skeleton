require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
  c.before :all do
    block = self.class.metadata[:example_group_block]
    if RUBY_VERSION.start_with?('1.8')
      file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    else
      file = block.source_location.first
    end
    dirname = Pathname.new(file).dirname
    host = File.basename(dirname)
    if c.host != host
      c.ssh.close if c.ssh
      c.host = host
      # Ask Vagrant once for SSH config of host
      config_file = File.join(dirname, '.ssh_config')
      unless File.file?(config_file)
        ssh_config = `vagrant ssh-config #{host} --host #{host}`
        File.open(config_file, 'w') { |file| file.write(ssh_config) }
      end
      options = Net::SSH::Config.for(c.host, files=[config_file])
      user = options[:user] || Etc.getlogin
      c.ssh = Net::SSH.start(c.host, user, options)
      c.os = backend(Serverspec::Commands::Base).check_os
    end
  end
end
