=begin
04/12/12

Eglem - Pinto

testBorne.rb
=end

require "test/unit"
require "./borne.rb"
require "../../Tests/fauxParking.rb"


#Class Test_borne
#
#Classe rassemblant les test unitaires d'une borne
class Test_borne < Test::Unit::TestCase

	def setup
		@parkFake = FauxParking.new
		@abonneFake = FauxAbonne.new("nomTest","prenomTest","1 rue du test","0506070809")
		@vehiculeFake = FauxVehicule.new("immTest",100,100)
		@placeFake = FaussePlace.new(1,0,100,100)
		@borne = Borne.new(parkFake.acces[0],"testBorne")
	end

	def test_new
		assert_instance_of(Borne,@borne,"Erreur lors de l'instanciation d'une borne")
		assert_equals([],@borne.listTickets,"Erreur : tickets d'une nouvelle borne pas []")
		assert_equals(false,@borne.autorisation,"Erreur : autorisation d'une nouvelle borne pas false")
	end	
	
	#Test de la methode abonner
	def test_abonner
		@borne.abonner(@vehiculeFake,@abonneFake)
		assert_not_equals(nil,@vehiculeFake.abonne,"Erreur : methode abonner ne lie pas le client au vehicule")
	end
	
	#Test de la methode upgrade
	def test_upgrade
		@borne.upgrade(@abonneFake)
		assert_equals(true,@abonneFake.hasPack,"Erreur : methode upgrade ne donne pas le pack au client")
	end

	#Test de la methode editerTicket
	def test_editerTicket(place,v)
		@borne.editerTicket(@placeFake,@vehiculeFake)
		assert_equals(1,@borne.listTickets.length,"Erreur : methode editerTicket ne modifie pas le tableau des tickets")
	end
	
end
