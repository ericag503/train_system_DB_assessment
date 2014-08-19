require 'spec_helper'

describe Lines do
  it 'initializes a new train line with a name' do
  test_line = Lines.new({:name => 'A'})
  expect(test_line).to be_an_instance_of Lines
  end	
end