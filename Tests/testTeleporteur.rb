=begin
05/12/12

Eglem - Pinto

testTeleporteur.rb
=end

require "test/unit"
require "../Sources/Modele/teleporteur.rb"

#Classe de test des teleporteurs
class Test_teleporteur < Test::Unit::TestCase

	#Setup
	def setup
		@teleporteur=Teleporteur.new
	end

	#Test d'instanciation
	def test_new
		assert_instance_of(Teleporteur,@teleporteur,"Porobleme instance teleporteur")
	end
end