=begin
04/12/12

Eglem - Pinto

acces.rb
=end

require './camera.rb'
require './borne.rb'
require './panneau.rb'
require './teleporteur.rb'

class Acces

	attr_reader :nom,:park,:teleporteurs,:panneau,:borne,:camera
	attr_writer :nom,:park,:teleporteurs

	def initialize(nom="",parking)
		self.nom= nom
		self.park= parking

		#Les bornes, interface client
		@borne = Borne.new("Borne-#{@nom}")

		#La camera
		@camera = Camera.new(00,"Camera-#{@nom}", park.hauteurMax, park.longueurMax)

		#Les deux téléporteur
		self.teleporteurs= [Teleporteur.new(1,self), Teleporteur.new(2,self)]
	end

	def capture_vehicule
		begin
			#Ouverture de la base de donnée
			$db = SQLite3::Database.open "dreampark.db"
			tableVehicule = $db.get_first_value "SELECT count(*) FROM sqlite_master WHERE type='table' AND name='vehicule'"
			begin
				v = camera.send_info
				if tableVehicule != 0 then
					listImmat = $db.execute "SELECT imm FROM vehicule"
					listImmat.each do |row|
						v[0] = "" if row == v[0]
					end
				end
			end until v[0].length == 4 and v[1].between?(10,park.hauteurMax) and v[2].between?(10,park.longueurMax)
			est_entre(Vehicule.new(*v))
			
		rescue SQLite3::Exception => e 	
			print "Exception occured : "
			puts e.message
		ensure
			$db.close if $db
		end
	end
	
	def capture_vehicule(immat, hauteur, longueur)
		veh=Vehicule.new(immat,hauteur,longueur)
		park.listClient.each { |client| return client if veh==client }
		park.lisAbonnes.each { |abonne| return abonne if veh==abonne }
		return veh
	end

	def est_entre(v)
		if park.nb_place_libre and park.where_to_park(v) then
			if v.is_abonne? then
				if not v.abonne.has_pack? then
					borne.controleur.ask_upgrade(v.abonne) if v.nbreVisites >= 10 #CAS : Proposer pack garanti
				end
				borne.controleur.ask_services #Params ????
			else
				borne.controleur.ask_abonnement(v) if v.nbreVisites >= 10 #CAS : Abonner le client
			end
		
			if borne.controleur.ask_paiement then
				numPlace = teleporteurs[0].transporter_garer(v)
				borne.editerTicket(numPlace,v) #if numPlace
				park.incrementer_panneaux
			end
		else
			#le garer quand même if v.is_abonne? and v.abonne.has_pack?
		end
	end

	def est_sorti
		teleporteurs[0].transporter_reprendre(v)
		park.decrementer_panneaux
	end
	
	def save(nomPark)
		$db.execute "INSERT INTO acce(nom, park) VALUES ('#{nom}', '#{nomPark}')"
		borne.save(nomPark, nom)
	end
end
