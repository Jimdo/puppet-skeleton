require 'puppetlabs_spec_helper/rake_tasks'

load File.expand_path('../test/vagrant.rake', __FILE__)

desc 'Run lint checks and spec examples'
task :travis => [:lint, :spec]

desc 'Run all tests'
task :test => [:lint, :spec, 'vagrant:provision', 'vagrant:halt']
