=begin
03/12/12

Eglem - Pinto

parking.rb
=end

class Parking

	attr_writer :place,:listAbonnes,:listVehicules
	attr_reader :place,:listAbonnes,:listVehicules

	def initialize(taille=100)
		@place = Array.new(taille)
		@listAbonnes = []
		@listVehicules = {}
	end

end