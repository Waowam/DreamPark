# -*- coding: utf-8 -*-

require ’gtk2’

class Builder < Gtk::Builder

	def initialize(xml)
		super()
		self << xml
		self[’window1’].signal_connect(’destroy’) { onDestroy }
		self[’window1’].show_all
		self.connect_signals{ |handler| method(handler) }
	end

	def onClick(w)
		case w.label
		when ’gtk-quit’
		onDestroy
		else
		puts "Vous avez cliqué sur : " + w.label
	end

	def onDestroy
		puts "# Dans onDestroy"
		Gtk::main_quit
	end

end

Gtk.init
builder = Builder.new("test_jerem.glade")
builder = Builder.new("test_dave.glade")
Gtk.main

