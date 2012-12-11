=begin
03/12/12

Eglem - Pinto

GestionPark.rb
=end


require "./parking.rb"
require "../../Sources/Controleur/ctrlGeneral.rb"

class GestionPark

	def initialize
		@parks = []
		@ctrl = Ctrl_gen.new(self)
	end

	def creerPark(nom="",niv,placeMax,hauteur,longueur)
		@parks<<Parking.new(nom,Parking.generate_place(niv,placeMax,hauteur,longueur))
		@ctrl.maj_parking
	end
end



