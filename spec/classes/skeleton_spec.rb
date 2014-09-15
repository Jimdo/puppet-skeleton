require 'spec_helper'

describe 'skeleton' do
  let (:facts) {{ :operatingsystem => 'debian' }}
  let (:params) {{ :command => '/bin/false', :package => 'git' }}

  it 'executes sample command' do
    should contain_exec('sample_command').with_command('/bin/false')
  end

  it 'installs sample package' do
    should contain_package('sample_package').with_name('git')
  end

  it 'does something' do
    pending 'Replace this with meaningful tests'
    fail
  end
end
