class Station 
	attr_reader :name, :id

	def initialize(attributes)
		@name = attributes[:name]
		@id = attributes[:id]
	end 

	def save
		results = DB.exec("INSERT INTO stations (name) VALUES ('#{name}') RETURNING id;")
		@id = results.first['id'].to_i
	end 

	def self.all
		results = DB.exec("SELECT * FROM stations;")
		stations = []
		results.each do |result|
			name = result['name']
			id = result['id'].to_i
			new_station = Station.new({:name => name, :id => id})
			stations << new_station
		end
		stations
	end

	def ==(another_station)
		self.name == another_station.name && self.id == another_station.id
	end
   
    def self.stops(line_id, station_id)
		results = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{line_id}, #{station_id}) RETURNING id;")
		@id = results.first['id'].to_i
	end
	
	def self.stations_to_lines(line_id)
	results = DB.exec("SELECT stations.* FROM train_lines JOIN stops ON (train_lines.id = stops.line_id) JOIN stations ON (stops.station_id = stations.id) WHERE line_id = #{line_id};")
	stations = []
	results.each do |result|
		name = result['name']
		id = result['id'].to_i
		new_station = Station.new({:name => name, :id => id})
		stations << new_station
	end
	stations
	end


end

