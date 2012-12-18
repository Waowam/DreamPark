=begin
04/12/12

Eglem - Pinto

camera.rb
=end

class Camera

	attr_reader :numero,:nom,:hauteurMax,:longueurMax
	attr_writer :numero,:nom,:hauteurMax,:longueurMax

	def initialize(num=0,nom, hauteurMax, longueurMax)
		self.numero= num
		self.nom= nom
		self.hauteurMax=hauteurMax
		self.longueurMax=longueurMax
	end

	#Par défaut send_info renvois les informations
	#captés par la camera dans une tableau 
	#de taille 3 avec :
	# - [0] = immatriculation
	# - [1] = hauteur
	# - [2] = longueur
	def send_info()
		imma = rand(Range.new(0,9999)).to_s
		hauteur= rand(Range.new(-100,hauteurMax+100))
		longueur= rand(Range.new(-100,longueurMax+100))
		return [imma,hauteur,longueur]
	end
end
