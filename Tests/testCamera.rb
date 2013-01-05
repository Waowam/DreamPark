=begin
04/12/12

Eglem - Pinto

testCamera.rb
=end

require "../Sources/Modele/camera.rb"
#Classe de test unitaire des cameras
#Regroupant l'ensemble des test 
class Test_camera < Test::Unit::TestCase
	HAUTMAX, LONGMAX = 200, 500

	#Setup variables
	def setup
		@cam = Camera.new(0,"camTest", HAUTMAX, LONGMAX)
	end

	#test de la methode send_info.
	def test_send_info()
		v = @cam.send_info()
	 	assert_equal(3, res.length, "Erreur : send_info tableau de taille incorrecte")
	 	assert_equal("String", res[1], "Erreur : send_info 1er element pas de classe String")
	 	assert_equal("Fixnum", res[2], "Erreur : send_info 2eme element pas de classe Fixnum")
	 	assert_equal("Fixnum", res[3], "Erreur : send_info 3eme element pas de classe Fixnum")
	end

	#Free variables
	def teardown
	end
end
