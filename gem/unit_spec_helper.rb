require 'rspec-puppet'

fixtures_path = ENV.fetch('FIXTURES_PATH', 'fixtures')

RSpec.configure do |c|
  c.module_path  = File.join(fixtures_path, 'modules')
  c.manifest_dir = File.join(fixtures_path, 'manifests-rspec')
end
