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
	#placeTailleNulle : erreur de taille
	#placeTailleNeg : erreur de taille
	def test_new
		assert(@placeOK, "Erreur creation placeOK")
		assert(!@placeTailleNulle, "Erreur : placeTailleNulle creee")
		assert(!@placeTailleNeg, "Erreur creation placeTailleNeg")
		
		assert(!@placeOK.vehicule, "Erreur : creation de placeOK non vide")
	end
	
end
