=begin
09/01/13

Eglem - Pinto

vueStats.rb
=end

require 'gtk2'

class VueStats

	attr_reader :builder,:ctrl,:window,:buffer,:endIter
	attr_writer :builder,:ctrl,:window,:buffer,:endIter

	def insert text
		buffer.insert(buffer.end_iter,text)
	end

	def cb_hide
		window.hide
	end

	def maj_stats text
		buffer.delete(buffer.start_iter,buffer.end_iter)
		insert text
		window.show_all
	end

	def initialize text
		#Builder de la fenetre
	  	@builder = Gtk::Builder.new
	  	@builder.add_from_file( "../Vue/vueStats.glade" )


		#Elements principaux
		@window       = builder.get_object( "vue_stats" ) #Fenetre entière
		@buffer 	  = builder.get_object( "stats_buffer" )	#BUFFFFEEERR
		@endIter 	  = buffer.end_iter

		#Init les buffers
		buffer.insert(endIter,text)
		endIter = buffer.end_iter

		window.show_all

		#Build des signaux
		builder.connect_signals{ |handler| method(handler) }
    end
end