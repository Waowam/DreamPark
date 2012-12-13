# -*- coding: utf-8 -*-

require 'gtk2'

class Builder < Gtk::Builder

	def initialize(xml)
		super()
		self << xml
		self['vue_main'].signal_connect('destroy') { onDestroy }
		self.connect_signals{ |handler| method(handler) }
	end

	def onDestroy
		Gtk::main_quit
	end

end

