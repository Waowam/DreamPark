=begin
04/12/12

Eglem - Pinto

fauxParking.rb
=end

require '../Sources/parking.rb'
require '../Sources/place.rb'

#Classe fournissant l'instance d'un parking mettant a disposition
#21 place de parking avec des numeros allant de 0 a 20
#et pour chaque numéro une place de parking avec :
# 	- hauteur : [150;250]
# 	- longueur : [350;450]
class FauxParking < Parking

	def initialize
		place = []
		for i in 0..20 do 
			place.push(Place.new(i,rand(150..250),rand(350..450)))
		end
		super("DreamParkTest",place)
	end
end