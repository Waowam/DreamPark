=begin
03/12/12

Eglem - Pinto

parking.rb
=end

require 'set'
require "./place.rb"
require "./acces.rb"

#Classe Parking
#
# Cette classe représente l'objet principal de la gestion
# du parking. Elle gère l'entrée/sortie de véhicules
# ainsi que la gestion des clients et des abonnées
class Parking

	attr_writer :place,:listAbonnes,:listVehicules,:nom
	attr_reader :place,:listAbonnes,:listVehicules,:nom,:accesNord,:accesSud

	def initialize(nom="DreamPark",places=[])
		@nom = nom
		@place = places
		@listAbonnes = Set.new
		@listClient = Set.new
		@accesNord = Acces.new("AccesNord",self)
		@accesSud = Acces.new("AccesSud",self)
	end

	#Ajoute un véhicule dans la liste correspondante.
	#is_abonne? => listAbonne
	#not is_abonne? => listClient
	def add_vehicule(p,v)
		p.vehicule = v
		v.up_nb_visite
		@listAbonnes.add(v) if v.is_abonne?
		@listClient.add(v) if not v.is_abonne?
	end

	#Remove le vehicule des listes
	def remove_vehicule(p,v)
		@listAbonnes.delete(p) if v.is_abonne?
		@listClient.delete(p) if not v.is_abonne?
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

	#Rapide vue en text d'un parking
	def to_s
		s= "Nom : #{@nom}\n"
		s+= "Nombre place totale : #{@place.length}\n"
		@place.each_with_index{ |p,i| s+= "Place #{i} : #{p}\n"}
		return s
	end


	#Méthode de class

	def self.generate_place(niveau,nbPlace,rangHaut,rangLong)
		p = []
		for niv in (0..niveau-1)
			for id in (1..nbPlace)
				idP = (niv*nbPlace)+id
				newP = Place.new(idP,niv,rand(Range.new(rangHaut[0].to_i,rangHaut[1].to_i)),rand(Range.new(rangLong[0].to_i,rangLong[1].to_i)))
				puts "#{newP}"
				p<<newP
			end
		end
		return p
	end

end
