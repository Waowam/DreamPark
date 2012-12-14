=begin
11/12/12

Eglem - Pinto

ctrlGeneral.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueGeneral.rb"

class Ctrl_gen

	attr_reader :mdl_gen,:vue_gen

	def initialize(mdl)
		@mdl_gen = mdl
		@vue_gen = VueGeneral.new(self)
	end

	def maj_combo
		names=["Nouveau"]
		mdl_gen.parks.each do |p| 
			names<<p.nom
		end
		return names
	end

	def post_newPark(park)
		mdl.creerPark(park[0],park[1],park[2],park[3],park[4])
	end

	def get_views(nom)
		ctrlP = mdl_gen.get_ctrl_park(nom)
		puts "#{ctrlP.class}"
		return [ctrlP.vue_par,ctrlP.vue_pan]
	end
end