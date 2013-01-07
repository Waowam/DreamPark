require './teleporteur.rb'

#Classe fournissant l'instance d'un teleporteur 
class FauxVehicule < Teleporteur

	attr_reader :id,:acces
	attr_writer :id,:acces

	def initialize(id, acces)
		self.id= id
		self.acces= acces
	end
end
