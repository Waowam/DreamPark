=begin
03/12/12

Eglem - Pinto

GestionPark.rb
=end

require 'gtk2'
require "./parking.rb"
require 'sqlite3'
require "../../Sources/Controleur/ctrlGeneral.rb"
require "./database.rb"

class GestionPark

	attr_accessor :parks

	def initialize
		#Recuperation des noms
		names = []
		begin
			#Ouverture de la base de donnée
			$db = SQLite3::Database.open "dreampark.db"
			
			Database.createTables
			
			parkInfo = $db.execute "SELECT nom FROM parking"
			parkInfo.each do |park|
				names<<park[0]
			end
			
		rescue SQLite3::Exception => e 
			
			print "Exception occured : "
			puts e.message
			
		ensure
			$db.close if $db
		end

		#Load des parkings
		@parks = []
		names.each do |n|
			@parks<<Database.load(n)
			
		end

		@ctrl = Ctrl_gen.new(self)
	end

	def creerPark(nom="",niv,placeMax,hauteur,longueur)
		p1 = Parking.new(nom,niv,placeMax,hauteur,longueur)
		@parks<<p1
	end

	def get_ctrl_park(nom)
		parking=""
		parks.each { |p| parking=p if p.nom==nom}
		return parking.ctrl_park
	end

	#Delete le parking correspondant au nom 
	#Retourne l'ancien-index du parking supprimé
	def delete_park nomP
		index = (-1)
		@parks.each_with_index { |e,i| index = i if e.nom==nomP}
		@parks.delete_at index if index != (-1)
		return index
	end
end

Gtk.init
ges = GestionPark.new
Gtk.main




