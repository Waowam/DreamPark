=begin
04/12/12

Eglem - Pinto

borne.rb
=end

require '../Controleur/ctrBorne.rb'

class Borne

	attr_reader :idBorne,:acces

	def initialize(acces)
		@ctrl = Ctrl_borne.new(self)
		@idBorne = 01
		@acces = 
	end

	def abonnerClient
		@ctrl.ask_abonnement
	end

	def editerTicker(place,imma)
	end
end