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

class GestionPark

	def initialize
		dreamPark = Parking.new(PlaceDispo)
	end
end

