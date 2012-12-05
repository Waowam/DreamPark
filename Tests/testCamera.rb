=begin
04/12/12

Eglem - Pinto

testCamera.rb
=end

require "../Sources/Modele/camera.rb"
#Classe de test unitaire des cameras
#Regroupant l'ensemble des test 
class Test_camera < Test::Unit::TestCase

	#Setup variables
	def setup
		@cam = Camera.new
	end

	#test d'instanciation de vehicule,
	#Ce test permet de verifier si le vehicule envoyé est bien le vehicule vu
	#par la camera.
	def test_send_info()
		res = ["imma",200,300]
		v = @cam.send_info("imma",200,300)
	 	assert_equal(res,v,"Send info erreur")
	end

	#Free variables
	def teardown
	end
end