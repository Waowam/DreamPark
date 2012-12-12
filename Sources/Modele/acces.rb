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

	attr_reader :nom,:park,:teleporteur1,:teleporteur2,:panneau,:borne1,:borne2
	attr_writer :nom,:park,:teleporteur1,:teleporteur2

	def initialize(nom="",parking)
		self.nom= nom
		self.park= parking
		#Initialisation des composants utiles

		#Les bornes, interface client
		@borne1 = Borne.new("Borne 1-#{@nom}")
		@borne2 = Borne.new("Borne 2-#{@nom}")

		#La camera
		@camera = Camera.new(00,"Camera-#{@nom}")

		#Le panneau
		@panneau = Panneau.new("Panneau-#{@nom}",@park.nb_place)

		#Les deux téléporteur
		self.teleporteur1(1)
		self.teleporteur2(2)
	end

	def capture_vehicule
		begin
			v = camera.send_info
		end while v[0].length == 4 and v[1].between?(10,$hauteur_max) and v[2].between?(10,$longeur_max)
		return v
	end

	def est_entre(v)
		park.garer(v)
	end

	def est_sorti
		park.reprendre(v)
	end
end
