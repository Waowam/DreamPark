#Classe TestPlace
#
#Classe permettant de tester les méthodes de la classe Place.
class TestPlace
	
	def setup
		@placeOK = Place.new(1,0,125,200)
		@placeTailleNulle = Place.new(1,0,0,0)
		@placeTailleNeg = Place.new(1,0,-10,-20)
		@placeOccupe = Place.new(1,0,100,100)
		@vehicule = FauxVehicule()
	end
	
	def teardown
	
	end
	
	def test_new
		assert(@placeOK, "Erreur creation placeOK")
		assert(@placeTailleNulle, "Erreur creation placeTailleNulle")
		assert(@placeTailleNeg, "Erreur creation placeTailleNeg")
		assert(@placeOccupe, "Erreur creation placeOccupe")
	end
	
	def test_occupe?
	
	end
	
end
