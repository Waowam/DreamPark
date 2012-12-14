class Abonne

	attr_writer :nom,:prenom,:adresse,:tel,:hasPack
	attr_reader :id,:nom,:prenom,:adresse,:tel

	def initialize(id,nom,prenom,adresse,tel)
		self.id=id
		self.nom=nom
		self.prenom=prenom
		self.adresse=adresse
		self.tel=tel
		@hasPack=false
	end
	
	def id=(i)
		raise ArgumentError.new("Error : id must be positive.") if i <= 0
		@id= i
	end
	
	def has_pack?
		self.hasPack
	end
	
	def save(db, nomPark)
		
	end
			
end

