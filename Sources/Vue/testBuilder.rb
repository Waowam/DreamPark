# -*- coding: utf-8 -*-

require 'gtk2'

class Builder < Gtk::Builder

	def initialize(xml)
		super()
		self << xml
		self['vue_config'].signal_connect('destroy') { onDestroy }
		self['vue_config'].show_all
		self.connect_signals{ |handler| method(handler) }
	end

	def onDestroy
		puts "# Dans onDestroy"
		Gtk::main_quit
	end

end

Gtk.init
builder = Builder.new("test_jerem.glade")
Gtk.main

