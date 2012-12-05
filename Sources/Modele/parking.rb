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

	def initialize(nom="DreamPark",niveau,places=[])
		@nom = nom
		@place = places
		@listAbonnes = []
		@listClient = []
	end

	#Ajoute un véhicule dans la liste correspondante.
	#is_abonne? => listAbonne
	#not is_abonne? => listClient
	def add_vehicule(p,v)
		p.vehicule = v
		@listAbonnes.push(p) if v.is_abonne? else @listClient.push(p)
	end

	#Remove le vehicule des listes et libère la place
	def remove_vehicule(p,v)
		@listAbonnes.delete(p) if v.is_abonne? else @listClient.delete(p)
		p.vehicule = nil
	end

	#Retourne le nombre de place libre
	def get_nb_place_libre
		som = @listAbonnes.length+@listClient.length
		return @place.length - som
	end

	#Retourne le nombre de place totale
	def get_nb_place
		return @place.length
	end

	#Choisis une place correspondante au vehicule donné
	def assigner_place(v)
		@place.each do |p|
			#blablablabla algo de recherche
			#selon la hauteur et la longueur
			# problematique : prendre la premier place libre avec h&l plus grand ? 
			# 					ou
			# 				  prendre la premiere place libre avec h&l plus grand mais de juste assez
			# 					pour garder les plus grandes places.
		end
	end

end