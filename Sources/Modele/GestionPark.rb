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
		@parks<<Parking.new("DreamPark",Parking.generate_place(3,20,[10,500],[10,500]))
		@ctrl = Ctrl_gen.new(self)
	end

	def creerPark(nom="",niv,placeMax,hauteur,longueur)
		@parks<<Parking.new(nom,Parking.generate_place(niv,placeMax,hauteur,longueur))
		@ctrl.maj_parking
	end

	def get_ctrl_park(nom)
		parking=""
		parks.each { |p| parking=p if p.nom==nom}
		return parking.ctrl_park
	end
end

Gtk.init
ges = GestionPark.new
Gtk.main




