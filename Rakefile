require 'puppetlabs_spec_helper/rake_tasks'

desc 'Run all tests'
task :test => [:lint, :spec]

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

  task :prepare_modules do
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

  task :provision => [:prepare_modules, :prepare_manifest, :export_vars] do
    # Provision VM depending on its state.
    case `vagrant status`
    when /The VM is running/ then ['provision']
    when /To resume this VM/ then ['up', 'provision']
    else ['up']
    end.each { |cmd| sh 'vagrant', cmd }
  end

  task :halt => :export_vars do
    sh 'vagrant', 'halt', '--force'
  end

  task :destroy => :export_vars do
    sh 'vagrant', 'destroy', '--force'
  end
end
