
require '../Sources/vehicule.rb'

#Classe fournissant l'instance d'un vehicule 
class FauxVehicule < Vehicule

	def initialize(imm="test",h=100,l=200)
		@immatriculation=imm
		@hauteur=h
		@longueur=l
	end
end
