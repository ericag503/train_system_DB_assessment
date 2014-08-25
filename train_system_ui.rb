require './lib/lines'
require './lib/station'
require 'pg'

DB = PG.connect(:dbname => 'train_system')

def welcome
	system("clear")
	puts "Welcome to the Train System"
	puts "Press [o] if you are an operator"
	puts "Press [r] if you are a rider"
	puts "OR [x] to exit the program"
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
	puts "Press [1] to add a train station"
	puts "Press [2] to add a train line" 
	puts "Press [3] to add a stop"
	puts "Press [4] to list all stations"
	puts "Press [5] to list all train lines"
	puts "OR [r] to return to the main menu"
	user_choice = gets.chomp
	if user_choice == '1'
		add_station
	elsif user_choice == '2'
		add_line
	elsif user_choice == '3'
		add_stop
	elsif user_choice == '4'
		list_station
	elsif user_choice == '5'
		list_lines
	elsif user_choice == 'r'
		welcome
	else 
		puts "Sorry that is not a valid option."
		operator_menu
	end 
end 

def rider_menu 
	puts "***Rider Menu***"
	puts "Press [t] to select a train line and view the associated stations."
	puts "Press [s] to select a station and view which trains go to it."
	puts "Press [r] to return to the main menu."
	user_choice = gets.chomp
	if user_choice == 't'
		stations_line
	elsif user_choice == 's'
		lines_station
	elsif user_choice == 'r'
		welcome
	else
		puts "Sorry that is not a valid option."
		rider_menu
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

def add_stop
	list_lines
	puts "Please enter the line id."
	user_line_id = gets.chomp
	list_station
	puts "Please enter the station id."
	user_station_id = gets.chomp
	new_stop = Station.stops(user_line_id, user_station_id)
	puts "You have added #{user_line_id} train line to #{user_station_id} station."
	puts "Press [1] to add another stop, or [r] to return to operator menu"
	user_choice = gets.chomp
	if user_choice == '1'
		add_stop
	elsif user_choice == 'r'
		operator_menu
	else
		"Not a valid option."
	end
end

def list_lines
	puts "Here are all of the train lines:"
	Lines.all.each do |line|
		puts "#{line.id}: #{line.name}"
	end
end

def list_station
	puts "Here are all of the train stations:"
	Station.all.each do |station|
		puts "#{station.id}: #{station.name}"
	end
end

def stations_line
	list_lines
	puts "Enter the number of the train line that you would like to see the stations for."
    user_choice = gets.chomp.to_i
    puts "Here are the stations:" 
    Station.stations_to_lines(user_choice).each do |station|
    	puts "#{station.id}: #{station.name}"
    end
    puts "Press [1] to see the stations for a different train line, or [r] to return to the rider menu"
    user_choice = gets.chomp
    if user_choice == '1'
    	stations_line
    elsif user_choice == 'r'
    	rider_menu
    else
    	puts "Not a valid option"
    end	
end

def lines_station
	list_station
	puts "Enter the number of the station that you would like to view the trains for."
	user_choice = gets.chomp.to_i
	Lines.lines_to_station(user_choice).each do |line|
		puts "#{line.id}: #{line.name}"
	end
end

		



welcome














