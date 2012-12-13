# -*- coding: utf-8 -*-

require 'gtk2'
require "./testVboxBuilder.rb"

class FrameBuilder < Gtk::Builder

	def initialize(xml)
		super()
		self << xml
		self['Testframe'].signal_connect('destroy') { onDestroy }
		self['button1'].signal_connect('clicked') { onClick }
		self['Testframe'].show_all
		self.connect_signals{ |handler| method(handler) }
	end

	def onDestroy
		puts "# Dans onDestroy"
		Gtk::main_quit
	end

	def onClick
		self['vbox1'].add_child(self,Gtk::Button.new("YEAH"),nil)
		self['vbox1'].show_all
	end

end

Gtk.init
builder = FrameBuilder.new("testframe.glade")
Gtk.main

