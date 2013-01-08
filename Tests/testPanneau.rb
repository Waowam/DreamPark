=begin
04/12/12

Eglem - Pinto

testPanneau.rb
=end

require "test/unit"
require "./panneau.rb"

#Test de la classe panneau
class Test_panneau < Test::Unit::TestCase

	#Test de 2 panneaux :
	#	panNoPlace : Nombre de place max = 0
	# 	pan : Nombre de place max = 3
	def setup
		@panNoPlace = Panneau.new("testPan")
		@pan = Panneau.new("testPan3Places",3)
	end

	#Test d'instantiacion des panneaux
	def test_new
		assert_instance_of(Panneau,@panNoPlace,"Erreur classe d'instance panneau")
		assert_equal(0,@panNoPlace.placeUsed,"Erreur texte du panneau")
		assert_equal(0,@panNoPlace.placeTot,"Erreur texte du panneau")
		
		assert_instance_of(Panneau,@pan,"Erreur classe d'instance panneau")
		assert_equal(0,@pan.placeUsed,"Erreur texte du panneau")
		assert_equal(3,@pan.placeTot,"Erreur texte du panneau")
	end

	#Test d'incrémentation du nombre de places utilisées
	def test_incrementer
		@panNoPlace.incrementer
		assert_equal(0,@panNoPlace.placeUsed)

		@pan.incrementer
		assert_equal(1,@pan.placeUsed)
		@pan.incrementer
		assert_equal(2,@pan.placeUsed)
		@pan.incrementer
		assert_equal(3,@pan.placeUsed)
		@pan.incrementer
		assert_equal(3,@pan.placeUsed)
	end

	#Test de décrémentation du nombre de places utilisées
	def test_decrementer
		@pan.decrementer
		assert_equal(0,@panNoPlace.placeUsed)
		
		@pan.placeUsed = 2
		@pan.decrementer
		assert_equal(1,@pan.placeUsed)
		@pan.decrementer
		assert_equal(0,@pan.placeUsed)
		@pan.decrementer
		assert_equal(0,@pan.placeUsed)
	end
end

