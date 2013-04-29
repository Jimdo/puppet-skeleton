require 'puppetlabs_spec_helper/rake_tasks'

namespace :vagrant do
  MODULE_NAME    = ENV.fetch('MODULE_NAME',
                             File.basename(File.dirname(__FILE__)).
                             sub(/^puppet-/, ''))
  FIXTURES_PATH  = ENV.fetch('FIXTURES_PATH',
                             File.join(ENV.fetch('TMPDIR', '/tmp'), 'fixtures'))
  MODULES_PATH   = File.join(FIXTURES_PATH, 'modules')
  MANIFESTS_PATH = File.join(FIXTURES_PATH, 'manifests')
  MANIFEST_FILE  = 'init.pp'

  task :export_vars do
    # Export settings to Vagrantfile.
    ENV['MODULES_PATH']   = MODULES_PATH
    ENV['MANIFESTS_PATH'] = MANIFESTS_PATH
    ENV['MANIFEST_FILE']  = MANIFEST_FILE
  end

  task :cleanup_modules do
    rm_rf MODULES_PATH
  end

  task :prepare_modules => :cleanup_modules do
    # Install module dependencies as specified in Puppetfile.
    sh 'librarian-puppet', 'install', '--path', MODULES_PATH
  end

  task :prepare_manifest do
    # Write manifest file as entry point for testing.
    mkdir_p MANIFESTS_PATH
    open(File.join(MANIFESTS_PATH, MANIFEST_FILE), 'w') do |f|
      f.write "include #{MODULE_NAME}\n"
    end
  end

  desc 'Provision the VM using Puppet'
  task :provision => [:prepare_modules, :prepare_manifest, :export_vars] do
    # Provision VM depending on its state.
    case `vagrant status`
    when /The VM is running/ then ['provision']
    when /To resume this VM/ then ['up', 'provision']
    else ['up']
    end.each { |cmd| sh 'vagrant', cmd }
  end

  desc 'SSH into the VM'
  task :ssh do
    sh 'vagrant', 'ssh'
  end

  desc 'Shutdown the VM'
  task :halt do
    sh 'vagrant', 'halt', '--force'
  end

  desc 'Destroy the VM'
  task :destroy => :export_vars do
    sh 'vagrant', 'destroy', '--force'
  end
end

desc 'Run lint checks and spec examples'
task :travis => [:lint, :spec]

desc 'Run all tests'
task :test => [:lint, :spec, 'vagrant:provision', 'vagrant:halt']
