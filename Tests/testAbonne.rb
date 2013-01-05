require "../Sources/Modele/abonne.rb"

#Classe TestAbonne
#
#Classe permettant de tester les méthodes de la classe Abonne.
class TestAbonne < Test::Unit::TestCase
	
	def setup
		@abonne = Abonne.new("testNom","testPrenom","testAdresse","0506070809")
	end
	
	def teardown
	
	end

	#Test des attributs apres l'instanciation d'un abonne
	def test_new
		assert_instance_of(Abonne, @abonne, "Erreur creation abonne")
		assert_equals(false, @abonne.hasPack, "Erreur creation abonne -> hasPack not false")
	end
	
	#Test de la methode hasPack?
	def test_hasPack?
		assert_equals(false, @abonne.hasPack?, "Erreur  abonne sans pack -> hasPack? not false")
		@abonne.hasPack=true
		assert(@abonne.hasPack?, "Erreur abonne avec pack -> hasPack? not true")
	end
	
end

