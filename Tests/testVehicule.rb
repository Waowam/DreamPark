require "../Sources/Modele/vehicule.rb"


#Classe TestVehicule
#
#Classe permettant de tester les méthodes de la classe Vehicule.
class TestVehicule < Test::Unit::TestCase
	IMMAT, HAUT, LONG = "IMM_OK", 125, 200
	
	def setup
		@vehiculeOK = Vehicule.new(IMMAT, HAUT, LONG )
	end
	
	def teardown
	
	end
	
	#Test des attributs apres l'instanciation d'un vehicule
	#vehiculeOK : place avec des attributs correct
	#vehicules incorrects (taille nulle ou négative) : lève ArgumentError
	def test_new
		assert_instance_of(Vehicule, @vehiculeOK, "Erreur creation vehiculeOK")
		assert_equal(nil, @vehiculeOK.abonne, "Erreur : creation de vehiculeOK -> abonne non nul")
		
		assert_raise(ArgumentError) {Vehicule.new("badNul",0,0)}
		assert_raise(ArgumentError) {Vehicule.new("badNeg",-10,-20)}
	end
	
	#Test incrementation / decrementation du nombre de visites d'un véhicule.
	def test_nbreVisites
		@vehiculeOK.incrementer_visite
		assert_equal(1, @vehiculeOK.nbreVisites, "Erreur : incrementer_visite impossible")
		
		@vehiculeOK.decrementer_visite
		assert_equal(0, @vehiculeOK.nbreVisites, "Erreur : decrementer_visite impossible")
		
		@vehiculeOK.decrementer_visite
		assert_equal(0, @vehiculeOK.nbreVisites, "Erreur : visites decrementes au dela de zero")
	end
	
end
