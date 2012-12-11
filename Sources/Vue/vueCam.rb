=begin
11/12/12

Eglem - Pinto

vueBorne.rb
=end

require 'gtk2'

class Vue_cam < Gtk::Window

	def initialize(name)
		super(name)
		self.show_all
	end
end

Gtk.init
Vue_cam.new
Gtk.main
