=begin
05/12/12

Eglem - Pinto

testTeleporteur.rb
=end

require "test/unit"
require "./teleporteur.rb"

#Classe de test des teleporteurs
class Test_teleporteur < Test::Unit::TestCase

	#Setup
	def setup
		@parkTest= FauxParking.new()
		@accesTest= FauxAcces.new("test",@parkTest)
		@teleporteur=Teleporteur.new(1,@parkTest.acces[1])
	end

	#Test d'instanciation
	def test_new
		assert_instance_of(Teleporteur,@teleporteur,"Porbleme instance teleporteur")
	end
end
