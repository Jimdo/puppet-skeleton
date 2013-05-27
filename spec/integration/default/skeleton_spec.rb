require_relative '../spec_helper'

describe file('/var/lib/puppet') do
  it { should be_directory }
end

describe package('tree') do
  it { should be_installed }
end
