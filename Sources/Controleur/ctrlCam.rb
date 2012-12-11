=begin
11/12/12

Eglem - Pinto

ctrlCam.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueCam.rb"

class Ctrl_cam

	def initialize(cam)
		@mdl_cam = cam
		@vue_cam = Vue_cam.new(@mdl_cam.nom)
		@vue_cam.show_all
	end

	def pop_Vehicule
		
	end
end