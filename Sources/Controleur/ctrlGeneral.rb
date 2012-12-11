=begin
11/12/12

Eglem - Pinto

ctrlGeneral.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueGen.rb"

class Ctrl_gen

	def initialize(mdl)
		@mdl_gen = mdl
		@vue_gen = Vue_panneau.new(@mdl_pan.nom)
		@vue_pan.show_all
	end

	def maj
	end
end