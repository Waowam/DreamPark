#Classe Database
#
# Cette classe représente la base de données dans laquelle sera stocké
# les informations des parkings. Cela permettra de sauvegarder et charger des
# sessions
class Database
	
	#Créer les tables si elles n'existes pas déja.
	def self.createTables
		#----------Creation des tables----------#
				#TABLE PARKING
			$db.execute "CREATE TABLE IF NOT EXISTS parking(
				nom TEXT,
				nbNiv INTEGER,
				nbPlaceNiv INTEGER,
				hauteurMax INTEGER,
				longueurMax INTEGER,
				PRIMARY KEY(nom))"
				
				#TABLE ACCE
			$db.execute "CREATE TABLE IF NOT EXISTS acce(
				nom TEXT,
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(nom,park))"
				
				#TABLE PANNEAU
			$db.execute "CREATE TABLE IF NOT EXISTS panneau(
				nom TEXT, 
				placeUsed INTEGER, 
				placeTot INTEGER, 
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(nom,park))"
				
				#TABLE BORNE
			$db.execute "CREATE TABLE IF NOT EXISTS borne(
				nom TEXT,
				park TEXT,
				acce TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				FOREIGN KEY(acce) REFERENCES acce(nom),
				PRIMARY KEY(nom,park))"
				
				#TABLE TICKET
			$db.execute "CREATE TABLE IF NOT EXISTS ticket(
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
			$db.execute "CREATE TABLE IF NOT EXISTS place(
				num INTEGER, 
				niveau INTEGER, 
				hauteur INTEGER, 
				longueur INTEGER,
				vehicule TEXT,
				park TEXT,
				FOREIGN KEY(vehicule) REFERENCES vehicule(imm),
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(num, park))"
				
				#TABLE VEHICULE
			$db.execute "CREATE TABLE IF NOT EXISTS vehicule(
				imm TEXT, 
				hauteur INTEGER, 
				longueur INTEGER, 
				nbVisit INTEGER,
				nbEntretien INTEGER,
				nbMaintenance INTEGER, 
				aboNom REFERENCES abonne(nom),
				aboPrenom REFERENCES abonne(prenom),
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				FOREIGN KEY(aboNom) REFERENCES abonne(nom),
				FOREIGN KEY(aboPrenom) REFERENCES abonne(prenom),
				PRIMARY KEY(imm,park))"
				
				#TABLE ABONNE
			$db.execute "CREATE TABLE IF NOT EXISTS abonne(
				nom TEXT, 
				prenom TEXT, 
				adresse TEXT, 
				tel INTEGER, 
				hasPack BOOLEAN, 
				park TEXT,
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(nom, prenom))"
				
				#TABLE LIVRAISON
			$db.execute "CREATE TABLE IF NOT EXISTS livraison(
				dateTime TEXT, 
				adresse TEXT, 
				vehicule TEXT, 
				park TEXT,
				FOREIGN KEY(vehicule) REFERENCES vehicule(imm),
				FOREIGN KEY(park) REFERENCES parking(nom),
				PRIMARY KEY(dateTime, park))"
	end

	#Supprime les informations propres à un parking pour préparer la sauvegarde
	def self.save(nomParking)
			#-------------Drop des tables-------------#
			$db.execute "DELETE FROM parking WHERE nom='#{nomParking}'"
			$db.execute "DELETE FROM acce WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM panneau WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM borne WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM place WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM vehicule WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM abonne WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM ticket WHERE park='#{nomParking}'"
			$db.execute "DELETE FROM livraison WHERE park='#{nomParking}'"
	end
	
	#Méthode de chargement d'un parking donné
	def self.load(nomParking)
		begin
			#Ouverture de la base de donnée
			$db = SQLite3::Database.open "dreampark.db"
			
			parkInfo = $db.get_first_row "SELECT * FROM parking WHERE nom='#{nomParking}'"
			if parkInfo then
				park = Parking.new(parkInfo[0],parkInfo[1],parkInfo[2],parkInfo[3],parkInfo[4])
				park.load
				return park	
			end
			
		rescue SQLite3::Exception => e 
			
			print "Exception occured in load (database.rb) : "
			puts e.message
			
		ensure
			$db.close if $db
		end
	end
end
