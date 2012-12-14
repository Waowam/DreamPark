=begin
12/12/12

Eglem - Pinto

vueGeneral.rb
=end

require 'gtk2'

class VueGeneral

	attr_accessor :window,:create_dialog,:quit_dialog,:welcom_dialog,:ctrl,:builder,:combo

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
    	ctrl.post_info_newPark(park)
    end

    def cb_welcom
    	#Run the dialog
    	response = self.welcom_dialog.run()
    	self.welcom_dialog.hide()
    end

    def cb_charged
        if self.combo.active==0 then
            cb_newPark
        else
            #Recuperation des vues panneau et parking utile
            nomPark=self.combo.active_text
            vues=self.ctrl.get_views

            #Ajout des vues
            framePar.add_child(builder,vues[0],nil)
            framePan.add_child(builder,vues[1],nil)
        end
        #Show all
        @window.show_all
    end

    def initialize(ctrl)
        #Builder de la fenetre
        @builder = Gtk::Builder.new
        @builder.add_from_file( "../Vue/test_jerem.glade" )

        #Controleur général
        @ctrl 	= ctrl

        #Elements principaux
        @window       = builder.get_object( "vue_main" ) #Fenetre entière
        @create_dialog = builder.get_object( "d_newPark" ) #Dialogue de creation
        @welcom_dialog = builder.get_object( "d_welcom" ) #Dialogue de prechargement
        @quit_dialog  = builder.get_object( "RUSURE" ) #Dialogue de fermeture

        #Elements utiles
        @combo = Gtk::ComboBox.new(true) #Combo box des parkings
        @framePan = builder.get_object("align_panneau")
        @framePar = builder.get_object("align_parking")

        #Maj de la combobox
        @ctrl.maj_combo(builder,builder.get_object("VBox_OpenPark"),self.combo)
        builder.get_object("dialog-vbox1").add_child(builder,self.combo,nil)
        #Show all
        cb_welcom
        @window.show_all

        #Build des signaux
        builder.connect_signals{ |handler| method(handler) }
    end
end