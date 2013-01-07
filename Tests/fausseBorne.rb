require './borne.rb'

#Classe fournissant l'instance d'une borne 
class FauxVehicule < Borne
	attr_reader :nom,:listTickets,:autorisation
	attr_writer :nom,:listTickets

	def initialize(nom)
		self.nom = nom
		self.listTickets = []
		@autorisation=nil
	end
end
