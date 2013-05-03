require 'spec_helper'

describe 'skeleton' do
  let (:facts) { Hash.new }

  it 'executes sample command' do
    should contain_exec('sample_command').with_command('/bin/true')
  end

  it 'does something' do
    pending 'Replace this with meaningful tests'
  end
end
