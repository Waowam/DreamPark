=begin
04/12/12

Eglem - Pinto

borne.rb
=end
require "../../Sources/Controleur/ctrlBorne.rb"

class Borne

	attr_reader :nom

	def initialize(nom)
		@nom = nom
		@controleur = Ctrl_borne.new(self)
	end

	def abonnerClient
		 
	end

	def editerTicker(place,imma)
	end
end