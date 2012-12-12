=begin
04/12/12

Eglem - Pinto

teleporteur.rb
=end


class Teleporteur

	attr_reader :id
	attr_writer :id

	def initialize(id)
		self.id= id
	end

	def transporter_garer(v)
		acces.est_entree(v)
	end

	def transporter_reprendre(v)
		acces.est_sorti(v)
	end
end
