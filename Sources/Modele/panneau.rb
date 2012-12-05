=begin
04/12/12

Eglem - Pinto

panneau.rb
=end

#Classe panneau représentant le panneau
#d'affichage des places totales restantes.
class Panneau
	attr_accessor :place

	def initialize(place=0)
		@place=place
	end

	#Incremente le nombre de places restantes
	def incrementer
		@place+=1
	end

	#Decremente le nombre de places restantes
	def decrementer
		@place-=1
	end
end