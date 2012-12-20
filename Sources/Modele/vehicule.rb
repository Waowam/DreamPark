=begin
03/12/12

Eglem - Pinto

vehicule.rb
=end

class Vehicule

	attr_writer :immatriculation,:abonne,:nbreVisites,:nbreMaintenance,:nbreEntretien,:livraisons,:abonne
	attr_reader :immatriculation,:hauteur,:longueur,:nbreVisites,:nbreMaintenance,:nbreEntretien,:livraisons,:abonne

	def initialize(imma="",hauteur,longueur)
		self.immatriculation=imma
		self.hauteur=hauteur
		self.longueur=longueur
		self.nbreVisites=0
		self.nbreMaintenance=0
		self.nbreEntretien=0
		self.livraisons=[]
		self.abonne=nil
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
	
	def ==(v)
		return  false if v.class != Vehicule
		return  v.immatriculation == self.immatriculation && 
				v.hauteur == self.hauteur && v.longueur == self.longueur && 
				v.nbreVisites == self.nbreVisites && v.abonne == self.abonne
	end
	
	def to_s
		s = "IMM : #{immatriculation} Hauteur : #{hauteur} Longueur : #{longueur}"
	end
	
	def save(nomPark)
		$db.execute "INSERT INTO vehicule(imm, hauteur, longueur, nbVisit, nbEntretien, nbMaintenance, park) 
					 VALUES ('#{immatriculation}', #{hauteur}, #{longueur}, #{nbreVisites}, #{nbreEntretien}, #{nbreMaintenance}, '#{nomPark}')"

		if abonne then
			$db.execute "UPDATE vehicule SET aboNom='#{abonne.nom}' WHERE imm='#{immatriculation}' AND park='#{nomPark}'"
			$db.execute "UPDATE vehicule SET aboPrenom='#{abonne.prenom}' WHERE imm='#{immatriculation}' AND park='#{nomPark}'"
			abonne.save
		end
		
		#livraison.each { |l| l.save(nomPark, immatriculation) }
	end
			
end
