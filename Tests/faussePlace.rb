require '../Sources/place.rb'

#Classe fournissant l'instance d'une place 
class FaussePlace < Place

	attr_reader :num,:niveau,:hauteur,:longueur,:vehicule
	attr_writer :vehicule

	def initialize(num,niveau,hauteur,longueur)
		self.num=num
		self.niveau=niveau
		self.hauteur=hauteur
		self.longueur=longueur
		self.vehicule=nil
	end
end
