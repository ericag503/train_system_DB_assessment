require 'rspec'
require 'station'
require 'train_line'
require 'PG'

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
	config.after(:each) do
		DB.exec("DELETE FROM stations *;")
		DB.exec("DELETE FROM train_lines *;")
	end
end