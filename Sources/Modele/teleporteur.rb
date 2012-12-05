=begin
04/12/12

Eglem - Pinto

teleporteur.rb
=end


class Teleporteur

	def initialize()
		@idTp = 001
	end

	def transporter_garer(place)
		acces.est_entree(place)
	end

	def transporter_reprendre
		acces.est_sorti(place)
	end
end