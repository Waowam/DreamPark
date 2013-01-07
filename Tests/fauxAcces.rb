=begin
05/12/12

Eglem - Pinto

fauxAcces.rb
=end

require "./acces.rb"

class FauxAcces < Acces

	attr_reader :nom,:park,:teleporteurs,:panneau,:borne,:camera,:vehicule_temp
	attr_writer :nom,:park,:teleporteurs,:vehicule_temp

	def initialize(nom="",parking)
		self.nom= nom
		self.park= parking
		self.vehicule_temp=nil

		#Les bornes, interface client
		@borne = FausseBorne.new("Borne-#{@nom}")

		#La camera
		@camera = FausseCamera.new(00,"Camera-#{@nom}", park.hauteurMax, park.longueurMax)

		#Les deux téléporteur
		self.teleporteurs= [FauxTeleporteur.new(1,self), FauxTeleporteur.new(2,self)]
	end
	
end
