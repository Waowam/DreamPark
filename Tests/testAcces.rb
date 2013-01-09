require "./acces.rb"

#Classe permettant de tester les méthodes de la classe Acces.
class TestAcces < Test::Unit::TestCase
	
	#Variables
	#	parkFake : Objet fauxParking (simulant la classe Parking)
	#	acces : Objet testé
	def setup
		@parkFake = FauxParking.new
		@acces = Acces.new("testAcces",@parkFake)
	end
	
	def teardown
	
	end
	
	#Test des attributs apres l'instanciation d'un acces
	def test_new
		assert_instance_of(Acces, @acces, "Erreur creation acces")
	end
	
	#Test de la methode capture_vehicule_with_info
	def test_capture_vehicule_with_info
		assert_instance_of(Vehicule, @acces.capture_vehicule_with_info("test", 100, 100), "Erreur capture_vehicule_with_info ne renvoit pas un Vehicule")
	end
	
end
