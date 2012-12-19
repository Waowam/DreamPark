#Classe Livraison permettant de garder une trace des livraisons proposées.
class Livraison
	attr_reader :adresse,:dateTime,:vehicule
	attr_reader :adresse,:dateTime,:vehicule

	def initialize(dateTime, adresse, vehicule)
		self.dateTime=dateTime
		self.adresse=adresse
		self.vehicule=vehicule
	end
	
	def save(nomPark)
		#$db.execute "INSERT INTO panneau(nom, placeUsed, placeTot, park) VALUES ('#{nom}', #{placeUsed}, #{placeTot}, '#{nomPark}')"
	end

end


