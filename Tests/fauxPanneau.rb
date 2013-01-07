require './panneau.rb'

#Classe fournissant l'instance d'un panneau 
class FauxPanneau < Panneau

	attr_reader :placeUsed,:placeTot,:nom
	attr_writer :placeUsed,:placeTot,:nom

	def initialize(nom="",place=0)
		self.nom = nom
		self.placeUsed=0
		self.placeTot=place
	end
end
