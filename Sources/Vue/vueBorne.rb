=begin
05/12/12

Eglem - Pinto

vueBorne.rb
=end

require 'gtk2'

class Vue_borne

	attr_reader :builder,:window,:entree,:console,:buffer,:endIter,:answer

	def maj_iter
		endIter=buffer.end_iter
	end

	def insert text
		buffer.insert(endIter,text)
	end

	def clkd_valider
		answer=entree.text
	end

	def initialize ctrl
		 #Builder de la fenetre
        @builder = Gtk::Builder.new
        @builder.add_from_file( "../Vue/borne.glade" )

        #Controleur borne
        @ctrl 	= ctrl

        #Elements principaux
        @window       = builder.get_object( "vue_borne" ) #Fenetre entière
        @entree 	  = builder.get_object( "entry" ) #Entree texte
        @console 	  = builder.get_object( "text_console" ) #Console
        @buffer 	  = builder.get_object( "textbuffer1" )	#BUFFFFEEERR
        @endIter 	  = buffer.end_iter
        @answer		  = "-1"

        #Init les buffers
        buffer.insert(endIter,"Bienvenu !\n")
        endIter = buffer.end_iter

        #window.show_all

        #Build des signaux
        builder.connect_signals{ |handler| method(handler) }
	end
end

