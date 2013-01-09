class Abonne

	attr_writer :nom,:prenom,:adresse,:tel,:hasPack
	attr_reader :nom,:prenom,:adresse,:tel

	#Constructeur
	def initialize(nom,prenom,adresse,tel)
		self.nom=nom
		self.prenom=prenom
		self.adresse=adresse
		self.tel=tel
		self.hasPack=false
	end
	
	#Retourne vrai si l'abonné à le pack garantie. Faux sinon.
	def has_pack?
		self.hasPack
	end
	
	#Redéfinition de la méthode ==
	def ==(a)
		return  false if a.class != Abonne
		return  a.nom == self.nom && a.prenom == self.prenom && a.tel == self.tel && a.hasPack == self.hasPack
	end
	
	#Méthode de sauvegarde
	def save(nomPark)
		$db.execute "INSERT INTO abonne(nom, prenom, adresse, tel, hasPack, park) VALUES (#{nom}, #{prenom}, #{adresse}, #{tel}, #{hasPack}, '#{nomPark}')"
	end
			
end

