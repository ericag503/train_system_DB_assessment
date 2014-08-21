require 'spec_helper'

describe Lines do
  it 'initializes a new train line with a name' do
  test_line = Lines.new({:name => 'A'})
  expect(test_line).to be_an_instance_of Lines
  end

  it 'save a new train line to the database' do
  test_line = Lines.new({:name => 'A'})
  test_line.save
  expect(Lines.all).to eq [test_line]
  end

  it 'allows a particular train line to have a multiple station stops' do
  	test_line = Lines.new({:name => 'A'})
  	test_line.save 
  	test_station = Station.new({:name => 'Everett'})
  	test_station.save
  	test_station2 = Station.new({:name => 'Flanders'})
  	test_station2.save 
  	Lines.stops(test_line.id, test_station.id)
  	Lines.stops(test_line.id, test_station2.id)
  	stations = Station.stations_to_lines(test_line.id)
  	expect(stations).to eq [test_station, test_station2]
  end

end