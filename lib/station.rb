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
			new_station = Station.new({:name => name})
			stations << new_station
		end
		stations
	end

	def ==(another_station)
		self.name == another_station.name 
	end


end

