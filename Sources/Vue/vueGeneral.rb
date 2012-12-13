=begin
12/12/12

Eglem - Pinto

vueGeneral.rb
=end

require 'gtk2'

class VueGeneral

	attr_accessor :window,:create_dialog,:quit_dialog,:welcom_dialog,:ctrl,:builder

	def gtk_main_quit( window )
        Gtk::main_quit()
    end

	def cb_delete_event(window, event )
        # Run dialog
        response = self.quit_dialog.run()
        self.quit_dialog.hide()

        return response != -1
    end

    def cb_newPark
        # Run dialog
        response = self.create_dialog.run()
        self.create_dialog.hide()
        return response == 1
    end

    def create_park
    	park = [builder.get_object("nomPark").text,builder.get_object("d_niveau").value,builder.get_object("d_hauteur").value,builder.get_object("d_longueur").value]
    	puts "#{park}"
    	#ctrl.post_info_newPark(park)
    end

    def cb_welcom( button )
    	#Run the dialog
    	self.welcom_dialog.run()
    	self.welcom_dialog.hide()
    end

    def initialize(ctrl)
        @builder = Gtk::Builder.new
        @builder.add_from_file( "../Vue/test_jerem.glade" )

        @ctrl 	= ctrl
        @window       = builder.get_object( "vue_main" )
        @create_dialog = builder.get_object( "d_newPark" )
        @welcom_dialog = builder.get_object( "d_welcom" )
        @quit_dialog  = builder.get_object( "RUSURE" )

        @ctrl.maj_combo(builder,builder.get_object("VBox_OpenPark"))

        @window.show_all

        builder.connect_signals{ |handler| method(handler) }
    end
end