=begin
03/12/12

Eglem - Pinto

parking.rb
=end

require 'set'
require "./place.rb"
require "./acces.rb"
require "./database.rb"
require "../../Sources/Controleur/ctrlParking.rb"

#Classe Parking
#
# Cette classe représente l'objet principal de la gestion
# du parking. Elle gère l'entrée/sortie de véhicules
# ainsi que la gestion des clients et des abonnées
class Parking

	attr_writer :place,:listAbonnes,:listClient,:nom
	attr_reader :nom,:nbNiv,:nbPlaceNiv,:hauteurMax, :longueurMax, :place,:listAbonnes,:listClient,:acces,:panneaux,:ctrl_park

	def initialize(nom="DreamPark",nbNiv=1,nbPlaceNiv=50,hauteurMax=500,longueurMax=500)
		self.nom = nom
		self.nbNiv=nbNiv
		self.nbPlaceNiv=nbPlaceNiv
		self.hauteurMax=hauteurMax
		self.longueurMax=longueurMax
		self.place = Parking.generate_place(nbNiv,nbPlaceNiv,Range.new(50,hauteurMax),Range.new(50,longueurMax))
		self.listAbonnes = Set.new
		self.listClient = Set.new
		@acces = [Acces.new("AccesNord",self), Acces.new("AccesSud",self)]
		@panneaux = [Panneau.new("Panneau-1", self.nb_place), Panneau.new("Panneau-2", self.nb_place)]
		@ctrl_park = Ctrl_parking.new(self)
	end

	def nbNiv=(n)
		raise ArgumentError.new("Error : nbNiv (numbre of levels) must be positive.") if n < 0
		@nbNiv= n
	end
	
	def nbPlaceNiv=(n)
		raise ArgumentError.new("Error : nbPlaceNiv (numbre of place by level) must be positive.") if n < 0
		@nbPlaceNiv= n
	end
	
	def hauteurMax=(h)
		raise ArgumentError.new("Error : hauteurMax (maximum height of a place) must be greater than 100.") if h < 0
		@hauteurMax= h
	end
	
	def longueurMax=(l)
		raise ArgumentError.new("Error : longueurMax (maximum length of a place) must be greater than 100.") if l < 0
		@longueurMax= l
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
	
	#Retourne la liste des places coresspondant aux dimensions du véhivule
	#Retourne nil si aucune place trouvée
	def where_to_park(v)
		res=[]
		place.each do |p| #Peut être optimisé pour se rapprocher des dimension du véhicule
			if p.libre? and p.longueur >= v.longueur and p.hauteur >= v.hauteur then 
				res<<p
			end
		end
		res= nil if res == []
		return res
	end

	#Choisis une place correspondante au vehicule donné.
	#Retourne le numéro de la place attribuée.
	#Retourne -1 en cas d'echec.
	def assigner_place(v)
		listPlaces = where_to_park(v)
		if listPlaces then
			best = listPlaces[0]
			for i in (1...listPlaces.length) do
				if listPlaces[i].longueur <= best.longueur and listPlaces[i].hauteur <= best.hauteur or
				   listPlaces[i].longueur <= best.longueur and listPlaces[i].hauteur == best.hauteur or
				   listPlaces[i].longueur == best.longueur and listPlaces[i].hauteur <= best.hauteur then
				   best = listPlaces[i]
				  end
			end		
			best.vehicule = v if listPlaces
		end
		res = best ? best.num : nil
	end
	
	#Assigne une place à un véhicule et ajoute le client.
	def garer(v)
		numPlace = assigner_place(v)
		add_vehicule(v) if numPlace
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
	
	#Incremente le compteur des panneaux du parking
	def incrementer_panneaux
		panneaux.each do |p|
			p.incrementer
		end
	end
	
	#Decremente le compteur des panneaux du parking
	def decrementer_panneaux
		panneaux.each do |p|
			p.decrementer
		end
	end

	#Rapide vue en text d'un parking
	def to_s
		s= "Nom : #{nom}\n"
		for p in panneaux do
			s+= "#{p}\n"
		end
		place.each_with_index{ |p,i| s+= "Place #{i} : #{p}\n"}
		return s
	end

	def save
		begin
			#Ouverture de la base de donnée
			$db = SQLite3::Database.open "dreampark.db"
			
			#R.A.Z. de la base de données pour ce parking.
			Database.save(nom)
			
			#Sauvegarde du parking
			$db.execute "INSERT INTO parking(nom, nbNiv, nbPlaceNiv, hauteurMax, longueurMax) VALUES ('#{nom}',#{nbNiv},#{nbPlaceNiv},#{hauteurMax},#{longueurMax})"
			
			#Appel des méthodes save
			listAbonnes.each { |a| a.save(nom) }
			listClient.each { |c| c.save(nom) }
			place.each { |p| p.save(nom) }
			
			acces.each { |a| a.save(nom) }
			panneaux.each { |p| p.save(nom) }
			
			
		rescue SQLite3::Exception => e 
			
			print "Exception occured : "
			puts e.message
			
		ensure
			$db.close if $db
		end
	end
	
	def load
		#LOAD ! Plus qu'a........-_-..........T-T !
	end
	
	#Méthode de class

	def self.generate_place(niveau,nbPlace,rangHaut,rangLong)
		p = []
		for niv in (0...niveau)
			for id in (1..nbPlace)
				idP = (niv*nbPlace)+id
				newP = Place.new(idP,niv,rand(rangHaut),rand(rangLong))
				p<<newP
			end
		end
		return p
	end

end
