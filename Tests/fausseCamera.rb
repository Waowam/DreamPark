require './camera.rb'

#Classe fournissant l'instance d'une camera 
class FausseCamera < Camera

	attr_reader :numero,:nom,:hauteurMax,:longueurMax
	attr_writer :numero,:nom,:hauteurMax,:longueurMax

	def initialize(num=0, nom, hauteurMax, longueurMax)
		self.numero= num
		self.nom= nom
		self.hauteurMax=hauteurMax
		self.longueurMax=longueurMax
	end
end

