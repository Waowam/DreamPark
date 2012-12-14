=begin
04/12/12

Eglem - Pinto

teleporteur.rb
=end


class Teleporteur

	attr_reader :id,:acces
	attr_writer :id,:acces

	def initialize(id, acces)
		self.id= id
		self.acces= acces
	end

	def transporter_garer(v)
		acces.park.garer(v)
	end

	def transporter_reprendre(v)
		acces.park.reprendre(v)
	end
	
	def save(db, nomPark, nomAcce)
		db.execute "INSERT INTO teleporteur(id, park, acce) VALUES ('#{id}', '#{nomPark}', '#{nomAcce}')"
	end
end
