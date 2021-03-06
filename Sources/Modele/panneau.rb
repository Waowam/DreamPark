=begin
04/12/12

Eglem - Pinto

panneau.rb
=end


#Classe panneau représentant le panneau
#d'affichage des places totales restantes.
class Panneau
	attr_reader :placeUsed,:placeTot,:nom
	attr_writer :placeUsed,:placeTot,:nom

	#Constructeur
	def initialize(nom="",place=0)
		self.nom = nom
		self.placeUsed=0
		self.placeTot=place
	end
	
	#Incremente le nombre de places utilisées
	def incrementer
		self.placeUsed= placeUsed + 1 if placeUsed<placeTot
	end

	#Décremente le nombre de places utilisées
	def decrementer
		self.placeUsed-=1 if placeUsed > 0
	end

	#Redefinition de la méthode to_s
	def to_s
		s="#{nom} : #{placeUsed}/#{placeTot}"
	end
	
	#Méthode de sauvegarde
	def save(nomPark)
		$db.execute "INSERT INTO panneau(nom, placeUsed, placeTot, park) VALUES ('#{nom}', #{placeUsed}, #{placeTot}, '#{nomPark}')"
	end

end
