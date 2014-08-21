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

  it 'returns multiple trains associated with a particular station' do
	test_line = Lines.new({:name => 'A'})
	test_line.save
	test_line2 = Lines.new({:name => 'B'})
	test_line2.save
	test_station = Station.new({:name => 'Flanders'})
	test_station.save 
	Lines.stops(test_line.id, test_station.id)
	Lines.stops(test_line2.id, test_station.id)
	lines = Lines.lines_to_station(test_station.id)
	expect(lines).to eq [test_line, test_line2]
  end


end