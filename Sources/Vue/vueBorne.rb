=begin
05/12/12

Eglem - Pinto

vueBorne.rb
=end

require 'gtk2'

class Vue_borne < Gtk::Window

	def initialize
		super("Borne de Parking")
		self.show_all
	end
end

Gtk.init
Vue_borne.new
Gtk.main
