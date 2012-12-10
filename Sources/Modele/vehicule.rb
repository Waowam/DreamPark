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
		@niveau= h
	end
	
	def longueur=(l)
		raise ArgumentError.new("Error : longueur must be positive.") if l <= 0
		@niveau= l
	end
	
	def incrementer_visite
		@nbreVisites+= 1
	end
	
	def decrementer_visite
		@nbreVisites-= nbreVisites > 0 ? 1 : 0
	end
			
end
