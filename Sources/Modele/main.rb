=begin
10/12/12

Eglem - Pinto

main.rb
=end

require "./parking.rb"
require "gtk2"

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

# Output banner

banner()
puts

# do we have any input?!

if ARGV.length > 0
  usage()
  exit(1)
end

#puts "Administrateur merci de parametre votre parking - \n"
#puts "Nom : "
#until (nom = gets.chomp).match(/^.+$/) do
#   nom = gets.chomp
#end
#puts "Nombre de niveau : "
#until (niveau = gets.chomp).match(/^\d+$/) do
#   niveau = gets.chomp
#end
#puts "Nombre de place maximum par niveau :"
#until (nbPlaceMax = gets.chomp).match(/^\d+$/) do
#  nbPlaceMax = gets.chomp
#end
#puts "Intervalle de hauteur min-max : min-max"
#until (interHauteur = gets.chomp).match(/^\d+-\d+$/)do
#  interHauteur = gets.chomp
#end
#interHauteur = interHauteur.split('-')

#puts "Intervalle de longueur min-max : min-max"
#until (interLongueur = gets.chomp).match(/^\d+-\d+$/)do
#  interLongueur = gets.chomp
#end
#interLongueur = interLongueur.split('-')

#place = Parking.generate_place(niveau.to_i,nbPlaceMax.to_i,interHauteur,interLongueur)
place = Parking.generate_place(3,3,[100,500],[100,500])
$hauteur_max= 500
$longueur_max= 500

Gtk.init

park = Parking.new("Park King",place)

#veh = Vehicule.new("IMM",200,300)
#park.garer(veh)
#park.reprendre(veh)
#park.garer(veh)
#park.reprendre(veh)

puts park

park.acces[0].capture_vehicule #1
park.acces[0].capture_vehicule #2
park.acces[0].capture_vehicule #3
park.acces[0].capture_vehicule #4
park.acces[0].capture_vehicule #5
park.acces[0].capture_vehicule #6
park.acces[0].capture_vehicule #7
park.acces[0].capture_vehicule #8
park.acces[0].capture_vehicule #9
park.acces[0].capture_vehicule #10
park.acces[0].capture_vehicule #11

puts
puts park

#puts veh.nbreVisites

Gtk.main
