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
		#@vue_gen.show_all
	end

	def maj_combo(b,vbox)
		combo = Gtk::ComboBox.new(true)
		combo.append_text 'Nouveau..'
		mdl_gen.parks.each { |p| combo.append_text(p.nom)}
		vbox.add_child(b,combo,nil)
	end

	def post_newPark(park)
		mdl.creerPark(park[0],park[1],park[2],park[3],park[4])
	end
end