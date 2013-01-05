require "../Sources/Modele/parking.rb"

#Classe TestParking
#
#Classe permettant de tester les méthodes de la classe Parking.
class TestParking < Test::Unit::TestCase
	NBNIV, NBPLACENIV = 1, 50
	def setup
		@vehiculeFake = FauxVehicule.new("testVehi",200,200)
		@vehiculeNOKFake = FauxVehicule.new("testVehiNOK",2000,2000)
		@abonneFake = FauxAbonne.new("nom","prenom","adresse","0506070809")
		@placeFake = FaussePlace.new(1,0,300,300)
		@parking = Parking.new("DreamPark",NBNIV,NBPLACENIV,500,500)
	end
	
	def teardown
	
	end

	#Test des attributs apres l'instanciation d'un abonne
	def test_new
		assert_instance_of(Parking, @parking, "Erreur creation parking")
		assert_instance_of(Set, @parking.listAbonnes, "Erreur creation parking listAbonnes n'est pas un Set")
		assert_instance_of(Set, @parking.listClient, "Erreur creation parking listClient n'est pas un Set")
		assert_equals([], @parking.listLivraisons, "Erreur creation parking listLivraisons n'est pas un []")
		assert_not_equals([], @parking.place, "Erreur creation parking SANS places")
		assert_equals(2, @parking.acces.length, "Erreur creation parking mais pas 2 acces")
		assert_equals(2, @parking.panneaux.length, "Erreur creation parking mais pas 2 panneau")
	end
	
	#Test de la methode add_vehicule
	def test_add_vehicule
		@parking.add_vehicule(@vehiculeFake)
		assert_equals(1, @parking.listClient.length, "Erreur : add_vehicule (client) pas de modif de listCLient")
		assert_equals(0, @parking.listAbonnes.length, "Erreur : add_vehicule (client) modif de listAbonnes")
		
		@vehiculeFake.abonne = @abonneFake
		@parking.add_vehicule(@vehiculeFake)
		assert_equals(1, @parking.listClient.length, "Erreur : add_vehicule (abonne) modif de listCLient")
		assert_equals(0, @parking.listAbonnes.length, "Erreur : add_vehicule (abonne) pas de modif de listAbonnes")
	end
	
	#Test de la methode remove_vehicule
	def test_remove_vehicule
		@parking.listClient<<@vehiculeFake
		@parking.listAbonnes<<@vehiculeFake
		
		@placeFake.vehicule.@vehiculeFake
		@parking.remove_vehicule(@placeFake,@vehiculeFake)
		assert_equals(0, @parking.listClient.length, "Erreur : remove_vehicule (client) pas de modif de listCLient")
		assert_equals(1, @parking.listAbonnes.length, "Erreur : remove_vehicule (client) modif de listAbonnes")
		
		@vehiculeFake.abonne = @abonneFake
		@parking.remove_vehicule(@placeFake,@vehiculeFake)
		assert_equals(0, @parking.listClient.length, "Erreur : remove_vehicule (abonne) modif de listCLient")
		assert_equals(0, @parking.listAbonnes.length, "Erreur : remove_vehicule (abonne) pas de modif de listAbonnes")
	end

	#Test de la methode nb_place_libre
	def nb_place_libre
		assert_equals(NBNIV*NBPLACENIV, @parking.nb_place_libre, "Erreur : nombre de place libre incorrect")
		@parking.place[0].vehicule=@vehiculeFake
		assert_equals(NBNIV*NBPLACENIV-1, @parking.nb_place_libre, "Erreur : nombre de place libre apres attribution incorrect")
	end

	#Test de la methode nb_place
	def test_nb_place
		assert_equals(NBNIV*NBPLACENIV, @parking.nb_place, "Erreur : nombre de place total incorrect")
	end
	
	#Test de la methode assigner_place
	def test_assigner_place
		assert_instance_of(Fixnum, @parking.assigner_place(@vehiculeFake), "Erreur : assigner place (vehicule OK) ne retourne pas de Fixnum")
		assert_equals(nil, @parking.assigner_place(@vehiculeNOKFake), "Erreur : assigner place (vehicule NOK) ne retourne pas nil")
	end
	
end

