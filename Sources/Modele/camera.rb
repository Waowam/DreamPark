=begin
04/12/12

Eglem - Pinto

camera.rb
=end
require "../Sources/Controleur/ctrlCam.rb"

class Camera

	attr_reader :numero,:nom

	def initialize(num=0,nom)
		@ControleurCam = Ctrl_cam.new(self)
		@numero= num
		@nom = nom
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