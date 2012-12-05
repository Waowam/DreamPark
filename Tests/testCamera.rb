=begin
04/12/12

Eglem - Pinto

testCamera.rb
=end

#Classe de test unitaire des cameras
#Regroupant l'ensemble des test 
class test_camera < Test::Unit::TestCase

	#Setup variables
	def setup
		@cam = Camera.new
	end

	#test d'instanciation de vehicule,
	#Ce test permet de verifier si le vehicule envoyé est bien le vehicule vu
	#par la camera.
	def test_sendInfo()
		res = ["imma",200,300]
		v = @cam.sendInfo("imma",200,300)
	 	assert_equal(res,v,"Send info erreur")
	end

	#Free variables
	def teardown
	end
end