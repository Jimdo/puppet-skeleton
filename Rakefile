#
# Rake tasks to test your Puppet module
#
# Copyright (C) 2013 Mathias Lafeldt <mathias.lafeldt@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'rspec/core/rake_task'

# Get module name from directory name; strip "puppet-" prefix.
def module_name
  File.basename(File.dirname(__FILE__)).sub(/^puppet-/, '')
end

MODULE_NAME    = ENV.fetch('MODULE_NAME', module_name)
FIXTURES_PATH  = ENV.fetch('FIXTURES_PATH', 'fixtures')
MODULES_PATH   = File.join(FIXTURES_PATH, 'modules')
MANIFESTS_PATH = File.join(FIXTURES_PATH, 'manifests')
MANIFEST_NAME  = 'site.pp'
MANIFEST_FILE  = File.join('test', MANIFEST_NAME)

namespace :test do
  # Prepare module and its dependencies as specified in Puppetfile.
  task :prepare_modules do
    if File.file?('Puppetfile')
      sh 'librarian-puppet', 'install', '--path', MODULES_PATH, '--destructive'
    else
      rm_rf MODULES_PATH
      mkdir_p MODULES_PATH
    end

    module_dir = File.join(MODULES_PATH, module_name)
    mkdir_p module_dir
    cp_r Dir.glob('{files,lib,manifests,templates}'), module_dir
  end

  # Prepare manifest as entry point for testing.
  task :prepare_manifests do
    rm_rf MANIFESTS_PATH
    mkdir_p MANIFESTS_PATH
    cp MANIFEST_FILE, MANIFESTS_PATH
  end

  task :prepare => [:prepare_modules, :prepare_manifests]

  # Remove fixtures.
  task :cleanup do
    rm_rf FIXTURES_PATH
  end

  desc 'Check manifests with puppet-lint'
  task :lint do
    require 'puppet-lint/tasks/puppet-lint'
  end

  desc 'Run RSpec examples'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/{classes,defines,unit,functions,hosts}/**/*_spec.rb'
    t.rspec_opts = '--color --format documentation'
  end
  task :spec => :prepare

  desc 'Run test:lint and test:spec'
  task :travis => [:lint, :spec]
end

namespace :vagrant do
  # Export settings to Vagrantfile.
  task :export_vars do
    ENV['MODULES_PATH']   = MODULES_PATH
    ENV['MANIFESTS_PATH'] = MANIFESTS_PATH
    ENV['MANIFEST_FILE']  = MANIFEST_NAME  # relative to MANIFESTS_PATH
  end

  desc 'Provision the VM using Puppet'
  task :provision => ['test:prepare', :export_vars] do
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

desc 'Run test:lint, test:spec, and vagrant:provision'
task :test => ['test:lint', 'test:spec', 'vagrant:provision', 'vagrant:halt']

# Aliases for backwards compatibility and convenience
task :lint => 'test:lint'
task :spec => 'test:spec'

task :default => :test
