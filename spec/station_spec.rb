require 'spec_helper'
 
describe Station do
  it 'initializes a station with a name' do
  	test_station = Station.new({:name => 'Flanders'})
  	expect(test_station).to be_an_instance_of Station
  end
end