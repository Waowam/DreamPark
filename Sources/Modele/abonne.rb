class Abonne

	attr_writer :nom,:prenom,:adresse,:tel,:hasPack
	attr_reader :nom,:prenom,:adresse,:tel

	def initialize(nom,prenom,adresse,tel)
		self.nom=nom
		self.prenom=prenom
		self.adresse=adresse
		self.tel=tel
		self.hasPack=false
	end
	
	def id=(i)
		raise ArgumentError.new("Error : id must be positive.") if i <= 0
		@id= i
	end
	
	def has_pack?
		self.hasPack
	end
	
	def save(nomPark)
		$db.execute "INSERT INTO abonne(nom, prenom, adresse, tel, hasPack, park) VALUES (#{nom}, #{prenom}, #{adresse}, #{tel}, #{hasPack}, '#{nomPark}')"
	end
			
end

