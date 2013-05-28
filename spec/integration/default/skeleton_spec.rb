require_relative '../spec_helper'

describe 'default node' do
  describe file('/var/lib/puppet') do
    it { should be_directory }
  end

  describe package('tree') do
    it { should be_installed }
  end
end
