=begin
03/12/12

Eglem - Pinto

GestionPark.rb
=end

require 'gtk2'
require "./parking.rb"
require "../../Sources/Controleur/ctrlGeneral.rb"

class GestionPark

	attr_accessor :parks

	def initialize
		@parks = []
		p1 = Parking.new("DreamPark",3,20,500,500)
		@parks<<p1
		@parks<<Parking.new("ProutPark",3,20,500,500)
		@ctrl = Ctrl_gen.new(self)
	end

	def creerPark(nom="",niv,placeMax,hauteur,longueur)
		p1 = Parking.new(nom,niv,placeMax,hauteur,longueur)
		puts "#{p1}"
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




