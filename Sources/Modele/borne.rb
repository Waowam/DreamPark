=begin
04/12/12

Eglem - Pinto

borne.rb
=end
require "../../Sources/Controleur/ctrlBorne.rb"
require "./ticket.rb"

class Borne

	attr_reader :nom,:controleur,:listTickets,:autorisation
	attr_writer :nom,:listTickets,:autorisation

	def initialize(acces,nom)
		self.nom = nom
		self.listTickets = []
		@acces=acces
		@autorisation=false
		@controleur = Ctrl_borne.new(self)
	end

	#Lie le nouveau client abonné à son véhicule
	def abonner(v,c)
		v.abonne=c
	end
	
	#Abonne au pack garanti le client passé en paramètre
	def upgrade(c)
		c.hasPack=true
	end

	#creer un ticket pour un véhicule donné
	def editerTicket(place,v)
		listTickets<<Ticket.new(place, v)
	end
	
	def save(nomPark, nomAcce)
		$db.execute "INSERT INTO borne(nom, park, acce) VALUES ('#{nom}', '#{nomPark}', '#{nomAcce}')"
		listTickets.each { |t| t.save(nomPark, nom) }
	end

	def get_num_scenario
		return controleur.vue_borne.num_scenario
	end

	def change_num_scenario n
		controleur.vue_borne.num_scenario= n
	end

	def apply_scenarios
		case get_num_scenario
			when 1
				controleur.ask_abonnement
			when 2
				controleur.ask_services
			when 3
				controleur.ask_upgrade
			when 4
				controleur.ask_paiement
			when 5
				controleur.ask_adhesion 1
			when (-1)
				controleur.say_bybye
				controleur.reset_view
				@autorisation=true
				@acces.est_entre
		end
	end
end
