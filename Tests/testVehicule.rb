require "./vehicule.rb"
require "../../Tests/fauxAbonne.rb"


#Classe TestVehicule
#
#Classe permettant de tester les méthodes de la classe Vehicule.
class TestVehicule < Test::Unit::TestCase
	IMMAT, HAUT, LONG = "IMM_OK", 125, 200
	
	def setup
		@abonneFake = FauxAbonne.new("nomTest","prenomTest","1 rue du test","0506070809")
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
		assert_equal([], @vehiculeOK.livraisons, "Erreur : creation de vehiculeOK -> livraisons non []")
		assert_equal(0, @vehiculeOK.nbreEntretien, "Erreur : creation de vehiculeOK -> nbreEntretien non nul")
		assert_equal(0, @vehiculeOK.nbreMaintenance, "Erreur : creation de vehiculeOK -> nbreMaintenance non nul")
		assert_equal(0, @vehiculeOK.nbreVisites, "Erreur : creation de vehiculeOK -> nbreVisites non nul")
		
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
	
	#Test de la méthode is_abonne?
	def test_is_abonne?
		assert_equal(nil, @vehiculeOK.is_abonne?, "Erreur : new vehicule -> is_abonne? non nul")
		@vehiculeOK.abonne=abonneFake
		assert(@vehiculeOK.is_abonne?, "Erreur : is_abonne? pas true alors qu'attribut abonne existe")
	end
end
