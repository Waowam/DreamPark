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

	attr_reader :nom,:park,:teleporteurs,:panneau,:borne,:camera,:vehicule_temp
	attr_writer :nom,:park,:teleporteurs,:vehicule_temp

	#Constructeur
	def initialize(nom="",parking)
		self.nom= nom
		self.park= parking
		self.vehicule_temp=nil

		#Les bornes, interface client
		@borne = Borne.new(self,"Borne-#{@nom}")

		#La camera
		@camera = Camera.new(00,"Camera-#{@nom}", park.hauteurMax, park.longueurMax)

		#Les deux téléporteur
		self.teleporteurs= [Teleporteur.new(1,self), Teleporteur.new(2,self)]

	end

	#Capture un véhicule à partir des infos de la caméra et appelle la méthode est_entre
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
			end until v[0].length == 4 and v[1].between?(100,park.hauteurMax) and v[2].between?(100,park.longueurMax)
			est_entre(Vehicule.new(*v))
			
		rescue SQLite3::Exception => e 	
			print "Exception occured in capture_vehicule (acces.rb) : "
			puts e.message
		ensure
			$db.close if $db
		end
	end
	
	#Capture un véhicule à partir des paramètres donnés et appelle la méthode est_entre
	def capture_vehicule_with_info(immat, hauteur, longueur)
		veh=Vehicule.new(immat,hauteur,longueur)
		est_entre(veh)
	end

	#Déclenche les scénarios avec la borne pour garer le véhicule
	def est_entre v=nil
		@vehicule_temp=v if v!=nil
		#on determine le scenario initiale
		if v!=nil then
			vehicule_temp.is_abonne? ? borne.change_num_scenario(2) : borne.change_num_scenario(1)
			borne.controleur.show_view
			borne.apply_scenarios
		end
		if borne.autorisation==true then
			borne.autorisation=false
			numPlace = teleporteurs[0].transporter_garer(vehicule_temp)
			if numPlace then
				borne.editerTicket(numPlace.num,vehicule_temp) 
				park.incrementer_panneaux 
			else
				park.ctrl_park.alert_error "Aucune place ne correspond a ce vehicule : #{vehicule_temp}"
			end
		end
	end

	#Signale la reprise d'un véhicule
	def est_sorti(v)
		teleporteurs[0].transporter_reprendre(v)
		park.decrementer_panneaux
	end
	
	#Méthode de sauvegarde
	def save(nomPark)
		$db.execute "INSERT INTO acce (nom, park) VALUES ('#{nom}', '#{nomPark}')"
		borne.save(nomPark, nom)
	end
end
