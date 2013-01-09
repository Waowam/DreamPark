=begin
03/12/12

Eglem - Pinto

parking.rb
=end

require 'set'
require "./place.rb"
require "./acces.rb"
require "./abonne.rb"
require "./database.rb"
require "../../Sources/Controleur/ctrlParking.rb"

#Classe Parking
#
# Cette classe représente l'objet principal de la gestion
# d'un parking. Elle gère l'entrée/sortie de véhicules
# ainsi que la gestion des clients et des abonnées
class Parking

	attr_writer :place,:listAbonnes,:listClient,:nom,:acces,:panneaux,:services,:listLivraisons
	attr_reader :nom,:nbNiv,:nbPlaceNiv,:hauteurMax, :longueurMax, :place,:listAbonnes,:listClient,:acces,:panneaux,:ctrl_park,:services,:listLivraisons

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
		@listLivraisons = []
	end

	def nbNiv=(n)
		raise ArgumentError.new("Error : nbNiv (numbre of levels) must be positive.") if n <= 0
		@nbNiv= n
	end
	
	def nbPlaceNiv=(n)
		raise ArgumentError.new("Error : nbPlaceNiv (numbre of place by level) must be positive.") if n <= 0
		@nbPlaceNiv= n
	end
	
	def hauteurMax=(h)
		raise ArgumentError.new("Error : hauteurMax (maximum height of a place) must be greater than 100.") if h < 100
		@hauteurMax= h
	end
	
	def longueurMax=(l)
		raise ArgumentError.new("Error : longueurMax (maximum length of a place) must be greater than 100.") if l < 100
		@longueurMax= l
	end

	#Ajoute un véhicule dans la liste correspondante.
	#is_abonne? => listAbonne
	#not is_abonne? => listClient
	def add_vehicule(p,v)
		v.incrementer_visite
		listAbonnes.add(v) if v.is_abonne?
		listClient.add(v) if not v.is_abonne?
		p.vehicule = v
	end

	#Remove le vehicule des listes
	def remove_vehicule(p,v)
		listAbonnes.delete(v) if v.is_abonne?
		listClient.delete(v) if not v.is_abonne?
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
		end
		res = best ? best : nil
	end
	
	#Assigne une place à un véhicule et ajoute le client.
	def garer(v)
		place = assigner_place(v)
		add_vehicule(place,v) if place
		return place
	end
	
	#Libere une place occupée.
	def reprendre(v)
		place.each do |p|
			if p.vehicule==v then
				remove_vehicule(p,v)
			end
		end
	end
	
	#Incremente le compteur des panneaux du parking
	def incrementer_panneaux
		panneaux.each do |p|
			p.incrementer
		end
		ctrl_park.show_vehicule
		ctrl_park.show_panneau
	end
	
	#Decremente le compteur des panneaux du parking
	def decrementer_panneaux
		panneaux.each do |p|
			p.decrementer
		end
	end

	#Retourne le vehicule correspondant aux valeurs passées en paramètre
	def get_vehicule_with_info (imma,haut,long)
		vehiculeTempo = nil
		listClient.each do |v|
			if v.immatriculation == imma && v.hauteur == haut && v.longueur == long then
				vehiculeTempo=v
			end
		end
		if vehiculeTempo==nil then
			listAbonnes.each do |v|
				if v.immatriculation == imma && v.hauteur == haut && v.longueur == long then
					vehiculeTempo=v
				end
			end
		end
		return vehiculeTempo
	end
	
	#Retourne les statistiques commerciales du parking
	#	client : nombre de client simple
	#	abonne : nombre de client abonnés
	#	entretien : nombre d'entretiens total
	#	maintenance : nombre de maintenances total
	#	livraison : nombre de livraisons total
	#	visites : nombre de visites total
	#	pack : nombre d'abonnés ayant souscris au pack garantie
	def stats_commercial
		stats=Hash.new(0)
		stats["client"]=listClient.length
		stats["abonne"]=listAbonnes.length
		
		listClient.each do |c|
			stats["entretien"]= stats["entretien"] + c.nbreEntretien
			stats["maintenance"]= stats["maintenance"] + c.nbreMaintenance
			stats["livraison"]= stats["livraison"] + c.livraisons.length
			stats["visites"]= stats["visites"] + c.nbreVisites
		end
		
		listAbonnes.each do |a|
			stats["entretien"]= stats["entretien"] + a.nbreEntretien
			stats["maintenance"]= stats["maintenance"] + a.nbreMaintenance
			stats["livraison"]= stats["livraison"] + a.livraisons.length
			stats["pack"]= stats["pack"] + 1 if a.is_abonne? and a.abonne.hasPack
			stats["visites"]= stats["visites"] + c.nbreVisites
		end
		return stats
	end
	
	#Retourne les statistiques admin du parking
	#	acces1 : nombre de passages pour l'accès 1
	#	acces2 : nombre de passages pour l'accès 2
	#	place : place la plus utilisée
	def stats_admin
		stats=Hash.new(0)
		
		stats["acces1"]=acces[0].borne.listTickets.length
		placeListA1=Hash.new(0)
		acces[0].borne.lisTickets.each do |t|
			placeListA1[t.place]= placeListA1[t.place] + 1 
		end
		place1=placeListA1.index(placeListA1.max)
		
		stats["acces2"]=acces[1].borne.listTickets.length
		placeListA2=Hash.new(0)
		acces[0].borne.lisTickets.each do |t|
			placeListA2[t.place]= placeListA2[t.place] + 1 
		end
		place2=placeListA2.index(placeListA2.max)
		stats["place"] = place1>place2 ?  place1 : place2
		return stats
	end

	#Vue en text d'un parking
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
			
			listLivraisons.each { |l| l.save(nom) }
			
		rescue SQLite3::Exception => e 
			
			print "Exception occured in save (parking.rb) : "
			puts e.message
			
		ensure
			$db.close if $db
		end
	end
	
	def load
		begin
			#Ouverture de la base de donnée
			$db = SQLite3::Database.open "dreampark.db"
			
			#Chargement des places, vehicules, abonnes
			placesInfos = $db.execute "SELECT * FROM place WHERE park='#{nom}'"
			if placesInfos then
				self.place = []
				placesInfos.each do |placeInf|
					placeTemp = Place.new(placeInf[0],placeInf[1],placeInf[2],placeInf[3])
					if placeInf[4] then
						vehiculeInfo = $db.get_first_row "SELECT * FROM vehicule WHERE park='#{nom}' AND imm='#{placeInf[4]}'"
						veh=Vehicule.new(vehiculeInfo[0],vehiculeInfo[1],vehiculeInfo[2])
						veh.nbreVisites=vehiculeInfo[3]
						if vehiculeInfo[4] then
							abonneInfo = $db.get_first_row "SELECT * FROM abonne WHERE park='#{nom}' AND nom='#{placeInf[4]}' AND prenom='#{placeInf[5]}'"
							if abonneInfo then
								abo = Abonne.new(abonneInfo[0],abonneInfo[1],abonneInfo[2],abonneInfo[3])
								abo.hasPack=abonneInfo[4]
								veh.abonne=abo
								self.listAbonnes<<veh
							else
								self.listClient<<veh
							end
						end
						placeTemp.vehicule=veh
					else
						placeTemp.vehicule=nil
					end
					self.place<<placeTemp
				end	
			end
			
			#Chargement des panneaux
			panneauxInfos = $db.execute "SELECT * FROM panneau WHERE park='#{nom}'"
			if panneauxInfos then
				self.panneaux = []
				panneauxInfos.each do |panneauInf|
					panel=Panneau.new
					panel.nom = panneauInf[0]
					panel.placeUsed= panneauInf[1]
					panel.placeTot= panneauInf[2]
					self.panneaux<<panel
				end
			end
			
			#Chargement des acces
			accesInfos = $db.execute "SELECT * FROM acce WHERE park='#{nom}'"
			if accesInfos then
				self.acces = []
				accesInfos.each do |acceInf|
					self.acces<<Acces.new(acceInf[0],self)
				end
			end
			
			@ctrl_park = Ctrl_parking.new(self)
			
		rescue SQLite3::Exception => e 
			
			print "Exception occured in load (parking.rb) : "
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
				newP = Place.new(idP,niv,rand(rangHaut),rand(rangLong))
				p<<newP
			end
		end
		return p
	end

end
