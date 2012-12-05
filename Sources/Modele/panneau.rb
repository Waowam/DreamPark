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

	def incrementer
		@place+=1
	end

	def decrementer
		@place-=1
	end
end