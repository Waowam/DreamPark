require "../Sources/Modele/place.rb"

#Classe TestPlace
#
#Classe permettant de tester les méthodes de la classe Place.
class TestPlace < Test::Unit::TestCase
	NUM, NIV, HAUT, LONG = 1, 0, 125, 200
	def setup
		@placeOK = Place.new(NUM, NIV, HAUT, LONG)
	end
	
	def teardown
	
	end
	
	#Test des attributs apres l'instanciation d'une place
	#placeOK : place avec des attributs correct
	#placeTailleNulle : erreur de taille (nulle)
	#placeTailleNeg : erreur de taille (negative)
	def test_new
		assert_instance_of(Place,@placeOK, "Erreur creation placeOK")
		assert_equal(nil, @placeOK.vehicule, "Erreur : creation de placeOK non vide")
		
		assert_raise(ArgumentError) {Place.new(1,0,0,0)}
		
		assert_raise(ArgumentError) {Place.new(1,0,-10,-20)}
	end
	
end
