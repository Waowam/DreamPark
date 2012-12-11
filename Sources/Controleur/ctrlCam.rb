=begin
11/12/12

Eglem - Pinto

ctrlCam.rb
=end

require "../Sources/Vue/vueCam.rb"

class Ctrl_cam

	def initialize(cam)
		@mdl_cam = cam
		@vue_borne = Vue_cam.new(cam.nom)
	end

	def pop_Vehicule
		
	end
end