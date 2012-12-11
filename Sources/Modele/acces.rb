=begin
04/12/12

Eglem - Pinto

acces.rb
=end

require './camera.rb'
require './borne.rb'
require './panneau.rb'
require './teleporteur.rb'


class Acces

	def initialize(nom="",parking)
		@nom = nom
		@park = parking
		#Initialisation des composants utiles

		#Les bornes, interface client
		@borne1 = Borne.new("Borne 1-#{@nom}")
		@borne2 = Borne.new("Borne 2-#{@nom}")

		#La camera
		@camera = Camera.new(00,"Camera-#{@nom}")

		#Le panneau
		@panneau = Panneau.new("Panneau-#{@nom}",@park.get_nb_place)

		#Les deux téléporteur
		@teleporteur1
		@teleporteur2
		#puts "#{self}"
	end

	def capture_vehicule
		#Il boucle sur la camera pour recuperé un vehicule
	end

	def est_entree
	end

	def est_sorti
	end
end