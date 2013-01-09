#Classe Livraison permettant de garder une trace des livraisons proposées.
class Livraison
	attr_reader :adresse,:dateTime
	attr_reader :adresse,:dateTime

	#Constructeur
	def initialize(dateTime, adresse)
		self.dateTime=dateTime
		self.adresse=adresse
	end
	
	#Méthode de sauvegarde
	def save(nomPark, immVehicule)
		$db.execute "INSERT INTO livraison(dateTime, adresse, vehicule, park) VALUES ('#{dateTime}', #{adresse}, #{immVehicule}, '#{nomPark}')"
	end

end


