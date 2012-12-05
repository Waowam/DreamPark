
#Classe fournissant l'instance d'un vehicule 
class FauxVehicule < Vehicule

	def initialize
		place = []
		for i in 0..20 do 
			place.push(Place.new(i,rand(150..250),rand(350..450)))
		end
		super("DreamParkTest",place)
	end
end
