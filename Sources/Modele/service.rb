#Classe service permettant de garder une trace des services proposés.
class Service
	attr_reader :entretien,:maintenance

	def initialize
		@entretien= Hash.new
		@maintenance= Hash.new
	end
	
	def add_entretien(v)
		@entretien[v.immatriculation]+=1
	end
	
	def add_maintenance(v)
		@maintenance[v.immatriculation]+=1
	end
	
	def save(nomPark)
		#$db.execute "INSERT INTO panneau(nom, placeUsed, placeTot, park) VALUES ('#{nom}', #{placeUsed}, #{placeTot}, '#{nomPark}')"
	end

end

