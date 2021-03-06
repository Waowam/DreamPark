=begin
04/12/12

Eglem - Pinto

testCamera.rb
=end

require "./camera.rb"

#Classe rassemblant les test unitaires d'une camera
class Test_camera < Test::Unit::TestCase
	HAUTMAX, LONGMAX = 200, 500

	#Variable 
	#	cam objet de type caméra
	def setup
		@cam = Camera.new(0,"camTest", HAUTMAX, LONGMAX)
	end

	#test de la methode send_info.
	def test_send_info()
		res = @cam.send_info()
	 	assert_equal(3, res.length, "Erreur : send_info tableau de taille incorrecte")
	 	assert_instance_of(String, res[0], "Erreur : send_info 1er element pas de classe String")
	 	assert_instance_of(Fixnum, res[1], "Erreur : send_info 2eme element pas de classe Fixnum")
	 	assert_instance_of(Fixnum, res[2], "Erreur : send_info 3eme element pas de classe Fixnum")
	end

	#Free variables
	def teardown
	end
end
