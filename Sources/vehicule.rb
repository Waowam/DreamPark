=begin
03/12/12

Eglem - Pinto

vehicule.rb
=end

class Vehicule

	attr_writer :immatriculation,:hauteur,:longueur
	attr_reader :immatriculation,:hauteur,:longueur

	def initialize(imma="",hauteur=0,longueur=0)
		@immatriculation=imma
		@hauteur=hauteur
		@longueur=longueur
	end
end