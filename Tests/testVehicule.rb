require "../Sources/Modele/vehicule.rb"


#Classe TestVehicule
#
#Classe permettant de tester les méthodes de la classe Vehicule.
class TestVehicule < Test::Unit::TestCase
	
	def setup
		@vehiculeOK = Vehicule.new("good",125,200)
		@vehiculeTailleNulle = Vehicule.new("badNul",0,0)
		@vehiculeTailleNeg = Vehicule.new("badNeg",-10,-20)
	end
	
	def teardown
	
	end
	
	#Test des attributs apres l'instanciation d'un vehicule
	#vehiculeOK : place avec des attributs correct
	#vehiculeTailleNulle : erreur de taille (nulle)
	#vehiculeTailleNeg : erreur de taille (négative)
	def test_new
		assert_instance_of(@vehiculeOK, "Erreur creation vehiculeOK")
		assert(!@vehiculeTailleNulle, "Erreur : vehiculeTailleNulle creee")
		assert(!@vehiculeTailleNeg, "Erreur creation vehiculeTailleNeg")
		
		assert(!@vehiculeOK.abonne, "Erreur : creation de vehiculeOK -> abonne non nul")
	end
	
end
