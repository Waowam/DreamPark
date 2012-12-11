=begin
11/12/12

Eglem - Pinto

ctrlPanneau.rb
=end

require 'gtk2'
require "../../Sources/Vue/vuePanneau.rb"

class Ctrl_pan

	def initialize(pan)
		@mdl_pan = pan
		@vue_pan = Vue_panneau.new(@mdl_pan.nom)
		@vue_pan.show_all
	end

	def maj
	end
end