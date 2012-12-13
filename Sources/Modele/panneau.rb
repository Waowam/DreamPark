=begin
04/12/12

Eglem - Pinto

panneau.rb
=end

require "../../Sources/Controleur/ctrlPanneau.rb"

#Classe panneau représentant le panneau
#d'affichage des places totales restantes.
class Panneau
	attr_reader :placeUsed,:placeTot,:nom,:ctrl_pan
	attr_writer :placeUsed,:placeTot,:nom

	def initialize(nom="",place=0)
		self.nom = nom
		self.placeUsed=0
		self.placeTot=place
		@ctrl_pan = Ctrl_pan.new(self)
	end
	
	#Incremente le nombre de places utilisées
	def incrementer
		self.placeUsed= placeUsed + 1 if placeUsed<placeTot
	end

	#Decremente le nombre de places utilisées
	def decrementer
		self.placeUsed-=1 if placeUsed > 0
	end

	#Redef to_s
	def to_s
		s="#{nom} : #{placeUsed}/#{placeTot}"
	end

end
