=begin
03/12/12

Eglem - Pinto

vehicule.rb
=end

class Vehicule

	attr_writer :immatriculation
	attr_reader :immatriculation,:hauteur,:longueur

	def initialize(imma="",hauteur=0,longueur=0)
		@immatriculation=imma
		self.hauteur=hauteur
		self.longueur=longueur
		@nbreVisites=0
	end
	
	def hauteur=(h)
		@hauteur = h > 0 ? h : 0
	end
	
	def longueur=(l)
		@longueur = l > 0 ? l : 0
	end
	
	def incrementer_visite
		@nbreVisites+= 1
	end
	
	def decrementer_visite
		@nbreVisites-= 1
	end
			
end
