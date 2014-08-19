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

end