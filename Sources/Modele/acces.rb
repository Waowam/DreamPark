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
		#Initialisation des composants utiles

		#Les bornes, interface client
		@borne = Borne.new("Borne-#{@nom}")

		#La camera
		@camera = Camera.new(00,"Camera-#{@nom}")

		#Les deux téléporteur
		self.teleporteurs= [Teleporteur.new(1,self), Teleporteur.new(2,self)]
	end

	def capture_vehicule
		begin
			v = camera.send_info
		end until v[0].length == 4 and v[1].between?(10,$hauteur_max) and v[2].between?(10,$longueur_max)
		est_entre(Vehicule.new(*v))
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
				borne.editerTicker(numPlace,v)
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
end
