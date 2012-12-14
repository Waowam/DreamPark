=begin
04/12/12

Eglem - Pinto

borne.rb
=end
require "../../Sources/Controleur/ctrlBorne.rb"
require "./ticket.rb"

class Borne

	attr_reader :nom,:controleur
	attr_writer :nom

	def initialize(nom)
		self.nom = nom
		@controleur = Ctrl_borne.new(self)
		listTickets = []
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
	def editerTicker(place,v)
		listTickets<<Ticket.new(place, v)
	end
	
	def save(db, nomPark, nomAcce)
		db.execute "INSERT INTO borne(nom, park, acce) VALUES ('#{nom}', '#{nomPark}', '#{nomAcce}')"
		listTickets.each { |t| t.save(db, nomPark, nom) }
	end
end
