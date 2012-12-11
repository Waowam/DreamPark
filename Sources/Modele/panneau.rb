=begin
04/12/12

Eglem - Pinto

panneau.rb
=end

#Classe panneau représentant le panneau
#d'affichage des places totales restantes.
class Panneau
	attr_accessor :placeLib,:placeTot

	def initialize(nom="",place=0)
		@nom = nom
		@placeLib=place
		@placeTot
	end

	#Incremente le nombre de places restantes
	def incrementer
		@placeLib+=1 if @placeLib >= @placeTot
	end

	#Decremente le nombre de places restantes
	def decrementer
		@placeLib-=1 if @place > 0
	end

	#Redef to_s
	def to_s
		s="#{@nom} : #{@placeLib}/#{@placeTot}"
	end

end