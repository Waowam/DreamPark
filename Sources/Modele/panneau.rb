=begin
04/12/12

Eglem - Pinto

panneau.rb
=end

require "../../Sources/Controleur/ctrlPanneau.rb"

#Classe panneau représentant le panneau
#d'affichage des places totales restantes.
class Panneau
	attr_reader :placeLib,:placeTot,:nom,:ctrl_pan
	attr_writer :placeLib,:placeTot,:nom

	def initialize(nom="",place=0)
		self.nom = nom
		self.placeLib
		self.placeTot=place
		@ctrl_pan = Ctrl_pan.new(self)
	end

	#Incremente le nombre de places restantes
	def incrementer
		placeLib+=1 if placeLib < placeTot
	end

	#Decremente le nombre de places restantes
	def decrementer
		placeLib-=1 if placeLib > 0
	end

	#Redef to_s
	def to_s
		s="#{nom} : #{placeLib}/#{placeTot}"
	end

end
