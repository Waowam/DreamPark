=begin
10/12/12

Eglem - Pinto

main.rb
=end

require "./parking.rb"

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

puts "Administrateur merci de parametre votre parking - \n"
puts "Nom : "
until (nom = gets.chomp).match(/^.+$/) do
   nom = gets.chomp
end
puts "Nombre de niveau : "
until (niveau = gets.chomp).match(/^\d+$/) do
   niveau = gets.chomp
end
puts "Nombre de place maximum par niveau :"
until (nbPlaceMax = gets.chomp).match(/^\d+$/) do
  nbPlaceMax = gets.chomp
end
puts "Intervalle de hauteur min-max : min-max"
until (interHauteur = gets.chomp).match(/^\d+-\d+$/)do
  interHauteur = gets.chomp
end
interHauteur = interHauteur.split('-')

puts "Intervalle de hauteur min-max : min-max"
until (interLongueur = gets.chomp).match(/^\d+-\d+$/)do
  interLongueur = gets.chomp
end
interLongueur = interLongueur.split('-')

place = Parking.generate_place(niveau.to_i,nbPlaceMax.to_i,interHauteur,interLongueur)

park = Parking.new(nom,place)
puts "#{park}"

