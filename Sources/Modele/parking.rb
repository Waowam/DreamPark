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

	attr_writer :place,:listAbonnes,:listClient,:nom
	attr_reader :place,:listAbonnes,:listClient,:nom,:accesNord,:accesSud

	def initialize(nom="DreamPark",places=[])
		self.nom = nom
		self.place = places
		self.listAbonnes = Set.new
		self.listClient = Set.new
		@accesNord = Acces.new("AccesNord",self)
		@accesSud = Acces.new("AccesSud",self)
	end

	#Ajoute un véhicule dans la liste correspondante.
	#is_abonne? => listAbonne
	#not is_abonne? => listClient
	def add_vehicule(v)
		v.incrementer_visite
		listAbonnes.add(v) if v.is_abonne?
		listClient.add(v) if not v.is_abonne?
	end

	#Remove le vehicule des listes
	def remove_vehicule(p,v)
		listAbonnes.delete(p) if v.is_abonne?
		listClient.delete(p) if not v.is_abonne?
		p.vehicule = nil
	end

	#Retourne le nombre de place libre
	def nb_place_libre
		res = 0
		place.each do |p|
			res+=1 if p.libre?
		end
		return res
	end

	#Retourne le nombre de place totale
	def nb_place
		return place.length
	end

	#Choisis une place correspondante au vehicule donné.
	#Retourne le numéro de la place attribuée.
	#Retourne -1 en cas d'echec.
	def assigner_place(v)
		res= nil
		place.each do |p| #Peut être optimisé pour se rapprocher des dimension du véhicule
			if not res and p.libre? and p.longueur >= v.longueur and p.hauteur >= v.hauteur then
				p.vehicule= v 
				res = p.num
			end
		end
		return res
	end
	
	#Assigne une place à un véhicule et ajoute le client.
	def garer(v)
		numPlace = assigner_place(v)
		add_vehicule(v) if numPlace != -1
		return numPlace
	end
	
	#Libere une place occupée.
	#Retourne le numéro de la place libérée.
	#Retourne -1 en cas d'echec.
	def reprendre(v)
		res= nil
		place.each do |p|
			if p.vehicule=v then
				p.vehicule= nil
				res= p.num
			end
		end
		return res
	end

	#Rapide vue en text d'un parking
	def to_s
		s= "Nom : #{@nom}\n"
		s+= "Nombre place totale : #{@place.length}\n"
		place.each_with_index{ |p,i| s+= "Place #{i} : #{p}\n"}
		return s
	end


	#Méthode de class

	def self.generate_place(niveau,nbPlace,rangHaut,rangLong)
		p = []
		for niv in (0...niveau)
			for id in (1..nbPlace)
				idP = (niv*nbPlace)+id
				newP = Place.new(idP,niv,rand(Range.new(rangHaut[0],rangHaut[1])),rand(Range.new(rangLong[0],rangLong[1])))
				p<<newP
			end
		end
		return p
	end

end
