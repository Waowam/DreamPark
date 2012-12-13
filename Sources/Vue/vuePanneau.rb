=begin
11/12/12

Eglem - Pinto

vuePanneau.rb
=end

require 'gtk2'

class Vue_panneau < Gtk::HBox

	attr_reader :ctrl

	def initialize(ctrl)
		super
		@ctrl = ctrl
		p = ctrl.get_txt_panneau
		@lbl_pan1 = Gtk::Label.new p[0]
		@lbl_pan2 = Gtk::Label.new p[1]
		self.add(@lbl_pan1).add(@lbl_pan2)
	end
end