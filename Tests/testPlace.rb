require "../Sources/Modele/place.rb"

#Classe TestPlace
#
#Classe permettant de tester les méthodes de la classe Place.
class TestPlace < Test::Unit::TestCase
	
	def setup
		@placeOK = Place.new(1,0,125,200)
		@placeTailleNulle = Place.new(1,0,0,0)
		@placeTailleNeg = Place.new(1,0,-10,-20)
	end
	
	def teardown
	
	end
	
	#Test des attributs apres l'instanciation d'une place
	#placeOK : place avec des attributs correct
	#placeTailleNulle : erreur de taille (nulle)
	#placeTailleNeg : erreur de taille (negative)
	def test_new
		assert_instance_of(Place,@placeOK, "Erreur creation placeOK")
		
		assert_raise(IllegalArgument) {@placeTailleNulle}
		
		assert(!@placeTailleNeg, "Erreur creation placeTailleNeg")
		
		assert(!@placeOK.vehicule, "Erreur : creation de placeOK non vide")
	end
	
end
