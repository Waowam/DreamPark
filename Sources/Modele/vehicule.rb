=begin
03/12/12

Eglem - Pinto

vehicule.rb
=end

class Vehicule

	attr_writer :immatriculation,:abonne
	attr_reader :immatriculation,:hauteur,:longueur,:nbreVisites,:abonne

	def initialize(imma="",hauteur,longueur)
		self.immatriculation=imma
		self.hauteur=hauteur
		self.longueur=longueur
		@nbreVisites=0
		@abonne=nil
	end
	
	def hauteur=(h)
		raise ArgumentError.new("Error : hauteur must be positive.") if h <= 0
		@hauteur= h
	end
	
	def longueur=(l)
		raise ArgumentError.new("Error : longueur must be positive.") if l <= 0
		@longueur= l
	end
	
	def incrementer_visite
		@nbreVisites+= 1
	end
	
	def decrementer_visite
		@nbreVisites-= nbreVisites > 0 ? 1 : 0
	end
	
	def is_abonne?
		abonne != nil
	end
	
	def to_s
		s = "IMM : #{immatriculation} Hauteur : #{hauteur} Longueur : #{longueur}"
	end
	
	def save(db, nomPark)
		db.execute "INSERT INTO vehicule(imm, hauteur, longueur, nbVisit, park) VALUES (#{immatriculation}, #{hauteur}, #{longueur}, #{nbreVisites}, '#{nomPark}')"
		db.execute "UPDATE vehicule SET aboNom='#{abonne.nom}'" if abonne
		db.execute "UPDATE vehicule SET aboPrenom='#{abonne.prenom}'" if abonne
	end
			
end
