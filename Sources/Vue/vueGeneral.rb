=begin
12/12/12

Eglem - Pinto

vueGeneral.rb
=end

require 'gtk2'

class VueGeneral

	attr_accessor :window,:create_dialog,:quit_dialog,:ctrl,:builder,:combo_main,:combo_load,:windowWelcom

	def gtk_main_quit
        Gtk::main_quit()
    end

	def cb_delete_event
        # Run dialog
        response = self.quit_dialog.run
        self.quit_dialog.hide()

        return response != -1
    end

    def cb_newPark
        # Run dialog
        response = self.create_dialog.run
        self.create_dialog.hide
        return response == 1
    end

    def create_park
    	park = [builder.get_object("nomPark").text,builder.get_object("d_niveau").value,builder.get_object("d_hauteur").value,builder.get_object("d_longueur").value]
    	puts "#{park}"
    	ctrl.post_info_newPark(park)
    end

    def cb_welcom
    	@windowWelcom.show_all
    end

    def cb_charged
        combo=builder.get_object("combo_park")
        if combo.active==0 then
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

    def first_load
        if combo_load.active==0 then
            cb_newPark
        else
            #Recuperation des vues panneau et parking utile
            nomPark=self.combo_load.active_text
            vues=self.ctrl.get_views nomPark

            #Ajout des vues
            framePar.add_child(builder,vues[0],nil)
            framePan.add_child(builder,vues[1],nil)
        end
        windowWelcom.hide
        window.show_all
    end


    def initialize(ctrl)
        #Builder de la fenetre
        @builder = Gtk::Builder.new
        @builder.add_from_file( "../Vue/test_jerem.glade" )

        #Controleur général
        @ctrl 	= ctrl

        #Elements principaux
        @window       = builder.get_object( "vue_main" ) #Fenetre entière
        @windowWelcom = builder.get_object( "win_welcom" ) #Fenetre de prechargement
        @create_dialog = builder.get_object( "d_newPark" ) #Dialogue de creation
        @quit_dialog  = builder.get_object( "RUSURE" ) #Dialogue de fermeture

        #Elements utiles
        @framePan = builder.get_object("align_panneau")
        @framePar = builder.get_object("align_parking")
        @combo_main = Gtk::ComboBox.new(true)
        @combo_load = Gtk::ComboBox.new(true)

        #Mise en place des t
        remplssge=@ctrl.maj_combo
        remplssge.each do |name|
            @combo_main.append_text(name)
            @combo_load.append_text(name)
        end
        @combo_main.active=0
        @combo_load.active=0

        #Maj de la combobox
        v_box_main=builder.get_object("VBox_OpenPark")
        v_box_main.add_child(builder,@combo_main,nil)
        v_box_welcom =builder.get_object("d_vbox_combo")
        v_box_welcom.add_child(builder,@combo_load,nil)
       
        #Show all
        cb_welcom
        #@window.show_all

        #Build des signaux
        builder.connect_signals{ |handler| method(handler) }
    end
end