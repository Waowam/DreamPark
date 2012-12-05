=begin
03/12/12

Eglem - Pinto

parking.rb
=end

#Classe Parking
#
# Cette classe représente l'objet principal de la gestion
# du parking. Elle gère l'entrée/sortie de véhicules
# ainsi que la gestion des clients et des abonnées
class Parking

	attr_writer :place,:listAbonnes,:listVehicules,:nom
	attr_reader :place,:listAbonnes,:listVehicules,:nom

	def initialize(nom="DreamPark",places=[])
		@nom = nom
		@place = places
		@listAbonnes = []
		@listClient = []
	end

	#Ajoute un véhicule 
	def add_vehicule(p,v)
		p.vehicule = v
		@listAbonnes.push(p) if v.is_abonne? else @listClient.push(p)
	end

	def remove_vehicule(p,v)
		@listAbonnes.delete(p) if v.is_abonne? else @listClient.delete(p)
		p.vehicule = nil
	end

	def get_nb_place
		som = @listAbonnes.length+@listClient.length
		return @place.length - som
	end

	def assigner_place
	end

end