=begin
04/12/12

Eglem - Pinto

teleporteur.rb
=end

require './acces.rb'

class Teleporteur

	def initialize(acces)
		@idTp = 001
		@acces=acces
	end

	def transporter_garer(place)
		acces.est_entree(place)
	end

	def transporter_reprendre
		acces.est_sorti(place)
	end
end