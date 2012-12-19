#Classe Livraison permettant de garder une trace des livraisons proposées.
class Livraison
	attr_reader :adresse,:dateTime,:vehicule
	attr_reader :adresse,:dateTime,:vehicule

	def initialize(dateTime, adresse)
		self.dateTime=dateTime
		self.adresse=adresse
	end
	
	def save(nomPark)
		#$db.execute "INSERT INTO panneau(nom, placeUsed, placeTot, park) VALUES ('#{nom}', #{placeUsed}, #{placeTot}, '#{nomPark}')"
	end

end


