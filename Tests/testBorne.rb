=begin
04/12/12

Eglem - Pinto

testBorne.rb
=end

require "test/unit"
require "../Sources/borne.rb"
require "./fauxAcces.rb"
require "./fauxParking.rb"


#Class Test_borne
#
#Classe rassemblant les test unitaires d'une borne
class Test_borne < Test::Unit::TestCase

	def setup
		@park = FauxParking.new
		@borne = Borne.new
	end

	#Test unitaire de l'abonnement d'un client
	#Verifie si pour un vehicule donnée
	#son abonnement est bien pris en compte
	def test_abonnerClient(vehicule)


	end

	#Test unitaire de l'impression d'un ticket
	#verifie si le ticket instancié est correct
	def test_editerTicket
	end

end