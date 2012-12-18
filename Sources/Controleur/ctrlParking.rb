=begin
13/12/12

Eglem - Pinto

ctrlParking.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueParking.rb"
require "../../Sources/Vue/vuePanneau.rb"

class Ctrl_parking

	attr_reader :mdl_par,:vue_par,:vue_pan

	def initialize(mdl)
		@mdl_par = mdl
		@vue_par = Vue_parking.new(self)
		@vue_pan = Vue_panneau.new(self)
	end

	def get_txt_panneau
		return [mdl_par.panneaux[0].to_s,mdl_par.panneaux[1].to_s]
	end

	def get_vehicule
		v = []
		plce = mdl_par.place
		plce.each do |p| 
			v<<p.vehicule if p.vehicule != nil
		end
		return v
	end

	def append_vehicule acces,tabV
		puts "HERE IN APPEND_VEHICULE + #{tabV}"

	end

	def remove_vehicule (iter)
		puts "HERE IN REMOVE_VEHICULE + #{iter}"
	end

	def get_info
		return [mdl_par.nom,mdl_par.nbNiv,mdl_par.nbPlaceNiv,mdl_par.hauteurMax,mdl_par.longueurMax]
	end
end