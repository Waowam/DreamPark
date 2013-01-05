
require '../Sources/vehicule.rb'

#Classe fournissant l'instance d'un vehicule 
class FauxVehicule < Vehicule

	attr_writer :immatriculation,:abonne,:nbreVisites,:nbreMaintenance,:nbreEntretien,:livraisons,:abonne
	attr_reader :immatriculation,:hauteur,:longueur,:nbreVisites,:nbreMaintenance,:nbreEntretien,:livraisons,:abonne

	def initialize(imma="",hauteur,longueur)
		self.immatriculation=imma
		self.hauteur=hauteur
		self.longueur=longueur
		self.nbreVisites=0
		self.nbreMaintenance=0
		self.nbreEntretien=0
		self.livraisons=[]
		self.abonne=nil
	end
end
