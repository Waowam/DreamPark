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

	def maj_combo(b,vbox,cmb)
		cmb.clear
		cmb.append_text 'Nouveau..'
		mdl_gen.parks.each { |p| cmb.append_text(p.nom)}
		cmb.active=0
		vbox.add_child(b,cmb,nil)
	end

	def post_newPark(park)
		mdl.creerPark(park[0],park[1],park[2],park[3],park[4])
	end

	def get_views(nom)
		ctrlP = get_ctr_park(nom)
		return [ctrlP.vue_par,ctrlP.vue_pan]
	end
end