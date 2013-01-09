=begin
03/12/12

Eglem - Pinto

vehicule.rb
=end

class Vehicule

	attr_writer :immatriculation,:abonne,:nbreVisites,:nbreMaintenance,:nbreEntretien,:livraisons,:abonne
	attr_reader :immatriculation,:hauteur,:longueur,:nbreVisites,:nbreMaintenance,:nbreEntretien,:livraisons,:abonne

	#Constructeur
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
	
	#Redifinition du setter pour la hauteur
	def hauteur=(h)
		raise ArgumentError.new("Error : hauteur must be positive.") if h < 100
		@hauteur= h
	end
	
	#Redifinition du setter pour la longueur
	def longueur=(l)
		raise ArgumentError.new("Error : longueur must be positive.") if l < 100
		@longueur= l
	end
	
	#Incrémentation du nombre de visites
	def incrementer_visite
		@nbreVisites+= 1
	end
	
	#Décrémentation du nombre de visites
	def decrementer_visite
		@nbreVisites-= nbreVisites > 0 ? 1 : 0
	end
	
	#Retourne vrai si le client est abonné, faux sinon.
	def is_abonne?
		abonne != nil
	end
	
	#Redéfinition de la méthode ==
	def ==(v)
		return  false if v.class != Vehicule
		return  v.immatriculation == self.immatriculation && 
				v.hauteur == self.hauteur && v.longueur == self.longueur && 
				v.nbreVisites == self.nbreVisites && v.abonne == self.abonne
	end
	
	#Redéfinition de la méthode to_s
	def to_s
		s = "IMM : #{immatriculation} Hauteur : #{hauteur} Longueur : #{longueur}"
	end
	
	#Méthode de sauvegarde
	def save(nomPark)
		$db.execute "INSERT INTO vehicule(imm, hauteur, longueur, nbVisit, nbEntretien, nbMaintenance, park) 
					 VALUES ('#{immatriculation}', #{hauteur}, #{longueur}, #{nbreVisites}, #{nbreEntretien}, #{nbreMaintenance}, '#{nomPark}')"

		if abonne then
			$db.execute "UPDATE vehicule SET aboNom='#{abonne.nom}' WHERE imm='#{immatriculation}' AND park='#{nomPark}'"
			$db.execute "UPDATE vehicule SET aboPrenom='#{abonne.prenom}' WHERE imm='#{immatriculation}' AND park='#{nomPark}'"
			abonne.save
		end
	end
			
end
