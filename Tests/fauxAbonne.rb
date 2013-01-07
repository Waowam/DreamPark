require './abonne.rb'

#Classe fournissant l'instance d'un abonne 
class FauxAbonne < Abonne

	attr_writer :nom,:prenom,:adresse,:tel,:hasPack
	attr_reader :nom,:prenom,:adresse,:tel

	def initialize(nom,prenom,adresse,tel)
		self.nom=nom
		self.prenom=prenom
		self.adresse=adresse
		self.tel=tel
		self.hasPack=false
	end
end

