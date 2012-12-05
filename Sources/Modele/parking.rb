=begin
03/12/12

Eglem - Pinto

parking.rb
=end

class Parking

	attr_writer :place,:listAbonnes,:listVehicules,:nom
	attr_reader :place,:listAbonnes,:listVehicules,:nom

	def initialize(nom="DreamPark",places=[])
		@nom = nom
		@place = places
		@listAbonnes = []
		@listClient = []
	end

	def add_vehicule(v)
		@place.push(v)
	end

	def remove_vehicule(v)
		@place.delete(v)
	end

	def get_nb_place
		return @place.length
	end

	def assigner_place
	end

end