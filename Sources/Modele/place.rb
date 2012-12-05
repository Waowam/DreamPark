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
		@num=num
		@niveau=niveau
		@vehicule=nil
		@hauteur=hauteur
		@longueur=longueur
	end
end
