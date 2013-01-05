=begin
04/12/12

Eglem - Pinto

fauxParking.rb
=end

require '../Sources/parking.rb'
require '../Sources/place.rb'

#Classe fournissant l'instance d'un parking
class FauxParking < Parking

	attr_writer :place,:listAbonnes,:listClient,:nom,:acces,:panneaux,:services,:listLivraisons
	attr_reader :nom,:nbNiv,:nbPlaceNiv,:hauteurMax, :longueurMax, :place,:listAbonnes,:listClient,:acces,:panneaux,:services,:listLivraisons

	def initialize(nom="DreamPark",nbNiv=1,nbPlaceNiv=50,hauteurMax=500,longueurMax=500)
		self.nom =nom
		self.nbNiv=nbNiv
		self.nbPlaceNiv=nbPlaceNiv
		self.hauteurMax=hauteurMax
		self.longueurMax=longueurMax
		
		self.place = FaussePlace.new(1,0,hauteurMax,longueurMax)
		self.listAbonnes = Set.new
		self.listClient = Set.new
		
		@acces = [FauxAcces.new("AccesNord",self), FauxAcces.new("AccesSud",self)]
		@panneaux = [FauxPanneau.new("Panneau-1", 1), FauxPanneau.new("Panneau-2", 1)]
		@listLivraisons = []
	end
end
