require "./place.rb"
require "../../Tests/fauxVehicule.rb"

#Classe TestPlace
#
#Classe permettant de tester les méthodes de la classe Place.
class TestPlace < Test::Unit::TestCase
	NUM, NIV, HAUT, LONG = 1, 0, 125, 200
	
	#Place de test :
	#	placeOK : place devant être valide
	def setup
		@placeOK = Place.new(NUM, NIV, HAUT, LONG)
		@vehiculeTest = FauxVehicule.new("test", HAUT, LONG)
	end
	
	def teardown
	
	end
	
	#Test des attributs apres l'instanciation d'une place
	#	placeOK : place avec des attributs correct et pas de vehicule
	#	places incorrectes (taille nulle ou négative) : lève ArgumentError
	def test_new
		assert_instance_of(Place, @placeOK, "Erreur creation placeOK")
		assert_equal(nil, @placeOK.vehicule, "Erreur : creation de placeOK non vide")
		
		assert_raise(ArgumentError) {Place.new(1,0,0,0)}
		assert_raise(ArgumentError) {Place.new(1,0,10,20)}
		assert_raise(ArgumentError) {Place.new(1,0,-10,-20)}
	end
	
	#Test de la methode libre? de la place
	def test_libre
		assert_equal(nil, @placeOK.libre?, "Erreur : creation de placeOK non vide")
		@placeOK.vehicule= vehiculeTest
		assert_not_equal(nil, @placeOK.libre?, "Erreur : attribution vehicule -> place vide")
	end
	
end
