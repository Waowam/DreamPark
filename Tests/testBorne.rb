=begin
04/12/12

Eglem - Pinto

testBorne.rb
=end

require "test/unit"
require "../Sources/Modele/borne.rb"


#Class Test_borne
#
#Classe rassemblant les test unitaires d'une borne
class Test_borne < Test::Unit::TestCase

	def setup
		@borne = Borne.new
	end

	def test_new
		assert_instance_of(Borne,@borne)
	end	
end