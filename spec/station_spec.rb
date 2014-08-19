require 'spec_helper'
 
describe Station do
  it 'initializes a station with a name' do
  	test_station = Station.new({:name => 'Flanders'})
  	expect(test_station).to be_an_instance_of Station
  end

  it 'saves a new station to the database' do
  	test_station = Station.new({:name => 'Flanders'})
  	test_station.save 
  	expect(Station.all).to eq [test_station]
  end
end