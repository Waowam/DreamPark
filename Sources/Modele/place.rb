=begin
05/12/12

Eglem - Pinto

place.rb
=end

class Place

	attr_accessor :num,:hauteur,:longueur

	def initialize(num,hauteur,longueur)
		@num=num
		@hauteur=hauteur
		@longueur=longueur
	end
end