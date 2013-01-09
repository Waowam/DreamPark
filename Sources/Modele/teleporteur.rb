=begin
04/12/12

Eglem - Pinto

teleporteur.rb
=end


class Teleporteur

	attr_reader :id,:acces
	attr_writer :id,:acces

	#Constructeur
	def initialize(id, acces)
		self.id= id
		self.acces= acces
	end

	#Gare le véhicule
	def transporter_garer(v)
		acces.park.garer(v)
	end

	#Reprend le véhicule
	def transporter_reprendre(v)
		acces.park.reprendre(v)
	end
end
