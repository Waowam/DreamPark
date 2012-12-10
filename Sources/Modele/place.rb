=begin
05/12/12

Eglem - Pinto

place.rb
=end


#Classe Place
#
#Classe représentant une place dans le parking.
#Elle est caractérisée par son numero, son niveau
#sa hauteur, sa longueur et son vehicule.
class Place

	attr_accessor :num,:niveau,:hauteur,:longueur

	def initialize(num,niveau,hauteur,longueur)
		self.num=num
		self.niveau=niveau
		self.hauteur=hauteur
		self.longueur=longueur
		@vehicule=nil
	end
	
	def num=(n)
		raise IllegalArgument, "Error : num must be positive." if n < 0
		@num= n
	end
	
	def niveau=(niv)
		raise IllegalArgument, "Error : niveau must be positive." if niv < 0
		@niveau= niv
	end
	
	def hauteur=(h)
		raise IllegalArgument, "Error : hauteur must be positive." if h < 0
		@niveau= h
	end
	
	def longueur=(l)
		raise IllegalArgument, "Error : longueur must be positive." if l < 0
		@niveau= l
	end
end
