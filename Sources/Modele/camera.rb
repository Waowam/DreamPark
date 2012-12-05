=begin
04/12/12

Eglem - Pinto

camera.rb
=end

class Camera

	attr_reader :numero,:moi

	def initialize
		@numero=0
		@moi = "JE SUIS UNE CAMERA"
	end

	#Par défaut send_info renvois les informations
	#captés par la camera dans une tableau 
	#de taille 3 avec :
	# - [0] = immatriculation
	# - [1] = hauteur
	# - [2] = longueur
	def send_info(imma="",hauteur,longueur)
		return [imma,hauteur,longueur]
	end
end