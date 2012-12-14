=begin
03/12/12

Eglem - Pinto

parking.rb
=end

require 'set'
require "./place.rb"
require "./acces.rb"
require "../../Sources/Controleur/ctrlParking.rb"

#Classe Parking
#
# Cette classe représente l'objet principal de la gestion
# du parking. Elle gère l'entrée/sortie de véhicules
# ainsi que la gestion des clients et des abonnées
class Parking

	attr_writer :place,:listAbonnes,:listClient,:nom
	attr_reader :place,:listAbonnes,:listClient,:nom,:acces,:panneaux,:ctrl_park

	def initialize(nom="DreamPark",places=[])
		self.nom = nom
		self.place = places
		self.listAbonnes = Set.new
		self.listClient = Set.new
		@acces = [Acces.new("AccesNord",self), Acces.new("AccesSud",self)]
		@panneaux = [Panneau.new("Panneau-1", self.nb_place), Panneau.new("Panneau-2", self.nb_place)]
		self.ctrl_park = Ctrl_parking.new(self)
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
			
			#-------------Drop des tables-------------#
			$db.execute "DROP TABLE IF EXISTS parking"
			$db.execute "DROP TABLE IF EXISTS acce"
			$db.execute "DROP TABLE IF EXISTS panneau"
			$db.execute "DROP TABLE IF EXISTS borne"
			$db.execute "DROP TABLE IF EXISTS place"
			$db.execute "DROP TABLE IF EXISTS vehicule"
			$db.execute "DROP TABLE IF EXISTS abonne"
			$db.execute "DROP TABLE IF EXISTS ticket"
			#$db.execute "DROP TABLE IF EXISTS service"
			#$db.execute "DROP TABLE IF EXISTS livraison"
			
			#----------Creation des tables----------#
				#TABLE PARKING
			$db.execute "CREATE TABLE parking(
				nom TEXT,
				PRIMARY KEY(nom))"
				
				#TABLE ACCE
			$db.execute "CREATE TABLE acce(
				nom TEXT,
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(nom,park))"
				
				#TABLE PANNEAU
			$db.execute "CREATE TABLE panneau(
				nom TEXT, 
				placeUsed INTEGER, 
				placeTot INTEGER, 
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(nom,park))"
				
				#TABLE BORNE
			$db.execute "CREATE TABLE borne(
				nom TEXT,
				park TEXT,
				acce TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				FOREIGN KEY(acce) REFERENCES acce(nom),
				PRIMARY KEY(nom,park))"
				
				#TABLE TICKET
			$db.execute "CREATE TABLE ticket(
				nom TEXT, 
				time TEXT,
				place INTEGER,
				vehicule TEXT,
				park TEXT,
				borne TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				FOREIGN KEY(place) REFERENCES place(num),
				FOREIGN KEY(borne) REFERENCES borne(nom),
				PRIMARY KEY(nom,park))"
			
				#TABLE PLACE
			$db.execute "CREATE TABLE place(
				num INTEGER, 
				niveau INTEGER, 
				hauteur INTEGER, 
				longueur INTEGER, 
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(num, park))"
				
				#TABLE VEHICULE
			$db.execute "CREATE TABLE vehicule(
				imm TEXT, 
				hauteur INTEGER, 
				longueur INTEGER, 
				nbVisit INTEGER, 
				place INTEGER, 
				aboNom REFERENCES abonne(nom),
				aboPrenom REFERENCES abonne(prenom),
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				FOREIGN KEY(aboNom) REFERENCES abonne(nom),
				FOREIGN KEY(aboPrenom) REFERENCES abonne(prenom),
				PRIMARY KEY(imm,park))"
				
				#TABLE ABONNE
			$db.execute "CREATE TABLE abonne(
				nom TEXT, 
				prenom TEXT, 
				adresse TEXT, 
				tel INTEGER, 
				hasPack BOOLEAN, 
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(nom, prenom))"
				
			#$db.execute "CREATE TABLE service(Nom TEXT PRIMARY KEY)"
			#$db.execute "CREATE TABLE livraison(Nom TEXT PRIMARY KEY)"
			
			#Sauvegarde du parking
			$db.execute "INSERT INTO parking(nom) VALUES ('#{nom}')"
			
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
