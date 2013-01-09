=begin
11/12/12

Eglem - Pinto

vuePanneau.rb
=end

require 'gtk2'

#Classe de vue des panneaux montrant les décomptents des places libres au fil des
#véhicules venants et allants
class Vue_panneau < Gtk::HBox

	attr_reader :ctrl

	#Constructeur
	def initialize(ctrl)
		super
		@ctrl = ctrl
		p = ctrl.get_txt_panneau
		@lbl_pan1 = Gtk::Label.new p[0]
		@lbl_pan2 = Gtk::Label.new p[1]
		self.add(@lbl_pan1).add(@lbl_pan2)
	end

	#Fonction de mise à jour des panneaux
	def maj_panneau
		p = ctrl.get_txt_panneau
		@lbl_pan1.set_text p[0]
		@lbl_pan2.set_text p[1]
	end
end