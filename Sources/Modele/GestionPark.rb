=begin
03/12/12

Eglem - Pinto

GestionPark.rb
=end

PlaceDispo = 100

begin

	require "./parking.rb"
	require "./vehicule.rb"
end

def banner()
  puts '____________________________________________________'
  puts "       ######                              "
  puts "       #     # #####  ######   ##   #    # "
  puts "       #     # #    # #       #  #  ##  ## "
  puts "       #     # #    # #####  #    # # ## # "
  puts "       #     # #####  #      ###### #    # "
  puts "       #     # #   #  #      #    # #    # "
  puts "       ######  #    # ###### #    # #    # "
  puts "                                           "
  puts "			  ######                       "
  puts "			  #     #   ##   #####  #    # "
  puts "			  #     #  #  #  #    # #   #  "
  puts "			  ######  #    # #    # ####   "
  puts "			  #       ###### #####  #  #   "
  puts "			  #       #    # #   #  #   #  "
  puts "			  #       #    # #    # #    # "
  puts '____________________________________________________'
  puts
end

def usage()
  script_name = $0 
  puts "Usage pour le projet dreamPark :\n"
  puts "ruby " + script_name
end

class GestionPark

	def initialize

		dreamPark = Parking.new("DreamPark v1",3)
	end
end

