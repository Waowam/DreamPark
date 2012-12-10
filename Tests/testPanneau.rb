=begin
04/12/12

Eglem - Pinto

testPanneau.rb
=end

require "test/unit"
require "..Sources/Modele/panneau.rb"

class Test_panneau < Test::Unit::TestCase

	def setup
		@pan = Panneau.new
	end

	def test_new
		assert_instance_of(Panneau,@pan,"Erreur classe d'instance panneau")
		assert_equal(0,@pan.place,"Erreur texte du panneau")
	end

	def test_incrementer
		@pan.incrementer
		assert_equal(1,@pan.place)
	end

	def test_decrementer
		@pan.decrementer
		assert_equel(0,@pan.place)
	end
end

