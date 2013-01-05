=begin
10/12/12

Eglem - Pinto

main.rb
=end

require "./parking.rb"
require "gtk2"
require "sqlite3"

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

if ARGV.length > 0
  usage()
  exit(1)
end

# Output banner
banner()
puts

Gtk.init

park = Parking.new("ParkKing",3,3,500,500)

puts park

park.acces[0].capture_vehicule #1
#park.acces[0].capture_vehicule #2
#park.acces[0].capture_vehicule #3
#park.acces[0].capture_vehicule #4
#park.acces[0].capture_vehicule #5
#park.acces[0].capture_vehicule #6
#park.acces[0].capture_vehicule #7
#park.acces[0].capture_vehicule #8
#park.acces[0].capture_vehicule #9
#park.acces[0].capture_vehicule #10
#park.acces[0].capture_vehicule #11

puts
puts park

park.save

puts "SAVED!"

parkLoaded = Database.load "ParkKing"

puts
puts
puts parkLoaded


Gtk.main
