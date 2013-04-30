require 'puppetlabs_spec_helper/rake_tasks'

namespace :vagrant do
  def module_name
    ENV.fetch('MODULE_NAME', File.basename(File.dirname(__FILE__)).sub(/^puppet-/, ''))
  end

  def fixtures_path
    root = ENV.fetch('TMPDIR', '/tmp')
    ENV.fetch('FIXTURES_PATH', File.join(root, 'puppet-fixtures', module_name))
  end

  MODULE_NAME    = module_name
  FIXTURES_PATH  = fixtures_path
  MODULES_PATH   = File.join(FIXTURES_PATH, 'modules')
  MANIFESTS_PATH = File.join(FIXTURES_PATH, 'manifests')
  MANIFEST_NAME  = 'site.pp'
  MANIFEST_FILE  = File.join('test', MANIFEST_NAME)

  # Export settings to Vagrantfile.
  task :export_vars do
    ENV['MODULES_PATH']   = MODULES_PATH
    ENV['MANIFESTS_PATH'] = MANIFESTS_PATH
    ENV['MANIFEST_FILE']  = MANIFEST_NAME  # relative to MANIFESTS_PATH
  end

  # Install module dependencies as specified in Puppetfile.
  task :prepare_modules do
    rm_rf MODULES_PATH
    mkdir_p MODULES_PATH
    sh 'librarian-puppet', 'install', '--path', MODULES_PATH
  end

  # Prepare manifest as entry point for testing.
  task :prepare_manifests do
    rm_rf MANIFESTS_PATH
    mkdir_p MANIFESTS_PATH
    cp MANIFEST_FILE, MANIFESTS_PATH
  end

  # Remove fixtures.
  task :cleanup do
    rm_rf FIXTURES_PATH
  end

  desc 'Provision the VM using Puppet'
  task :provision => [:prepare_modules, :prepare_manifests, :export_vars] do
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
    Rake::Task['vagrant:cleanup'].invoke
  end
end

desc 'Run lint checks and spec examples'
task :travis => [:lint, :spec]

desc 'Run all tests'
task :test => [:lint, :spec, 'vagrant:provision', 'vagrant:halt']
