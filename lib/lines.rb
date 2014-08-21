class Lines 
	attr_reader :name, :id

	def initialize(attributes)
		@name = attributes[:name]
		@id = attributes[:id]
	end 

	def save 
		results = DB.exec("INSERT INTO train_lines (name) VALUES ('#{name}') RETURNING id;")
		@id = results.first['id'].to_i
	end

	def self.all
		results = DB.exec("SELECT * FROM train_lines;")
		lines = []
		results.each do |result|
			name = result['name']
			new_line = Lines.new({:name => name})
			lines << new_line
		end
		lines
	end

	def ==(another_line)
		self.name == another_line.name
	end

	def self.stops(line_id, station_id)
		results = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{line_id}, #{station_id}) RETURNING id;")
		@id = results.first['id'].to_i
	end

	def self.lines_to_station(station_id)
		results = DB.exec("SELECT train_lines.* FROM stations JOIN stops ON (stations.id = stops.station_id) JOIN train_lines ON (stops.line_id = train_lines.id) WHERE station_id = #{station_id};")
		lines = []
		results.each do |result|
			name = result['name']
			id = result['id'].to_i
			new_line = Lines.new({:name => name, :id => id})
			lines << new_line
		end 
		lines
	end 



end