require './lib/lines'
require './lib/station'
require 'pg'

DB = PG.connect(:dbname => 'train_system')

def welcome
	puts "Welcome to the train system."
	puts "Press [o] if you are an operator, or [r] if you are a rider."
	puts "Press [x] to exit the program."
    user_choice = gets.chomp
    if user_choice == 'o'
    	operator_menu
    elsif user_choice == 'r'
    	rider_menu
    elsif user_choice == 'x'
    	puts "Have a crappy day!"
    	exit
    else 
    	puts "Sorry that is not a valid option."
    	welcome
    end 
end 

def operator_menu
	puts "***Operator Menu***"
	puts "Press [s] to add a train station, or [t] to add a train line."
	puts "Press [ls] to list all stations, or [lt] to list all train lines."
	puts "Press [r] to return to the main menu."
	user_choice = gets.chomp
	if user_choice == 's'
		add_station
	elsif user_choice == 't'
		add_line
	elsif user_choice == 'ls'
		list_station
	elsif user_choice == 'lt'
		list_lines
	elsif user_choice == 'r'
		welcome
	else 
		puts "Sorry that is not a valid option."
		operator_menu
	end 
end 

def add_station
	puts "Please enter the name of the station you would like to add."
	station_name = gets.chomp
	new_station = Station.new({:name => station_name})
	new_station.save 
	puts "'#{new_station.name}' has been added!"
	operator_menu
end 

def add_line
	puts "Please enter the name of train line you would like to add."
	train_line = gets.chomp
	new_line = Lines.new({:name => train_line})
	new_line.save
	puts "'#{new_line.name}' has been added!"
	operator_menu
end

def list_station
	puts "Here are all of the train stations:"
	Station.all.each do |station|
		puts "#{station.id}: #{station.name}"
	end
end

def list_lines
	puts "Here are all of the train lines:"
	Lines.all.each do |line|
		puts "#{line.id}: #{line.name}"
	end
end



welcome














