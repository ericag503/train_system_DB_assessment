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



