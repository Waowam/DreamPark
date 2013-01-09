=begin
12/12/12

Eglem - Pinto

vueGeneral.rb
=end

require 'gtk2'

class VueGeneral

	attr_accessor :window,:create_dialog,:quit_dialog,:ctrl,:builder,:combo_main,:combo_load,:windowWelcom,:framePar,:framePan

	def gtk_main_quit
<<<<<<< HEAD
        #@ctrl.save_all_da_park
=======
		ctrl.save_all_da_park
>>>>>>> 11df9389a144592ee3efa41a28aca8457f320d3e
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
    end

    def create_park
    	park = [builder.get_object("nomPark").text,builder.get_object("d_niveau").value.to_i,builder.get_object("d_nbPlaceM").value.to_i,builder.get_object("d_hauteur").value.to_i,builder.get_object("d_longueur").value.to_i]
    	ctrl.post_park_info(park)
        combo_main.append_text(park[0])
        combo_main.active = ctrl.nb_park
        cb_charged
    end

    def cb_welcom
    	@windowWelcom.show_all
    end

    def delete_park
       nomPark = builder.get_object("label_nomPark1").text
       indexComboPark = ctrl.del_park nomPark

       #Maj de la combo box
       combo_main.remove_text (indexComboPark+1)

       #Vidage des frames
        framePan.each{|child| framePan.remove(child)}
        framePar.each{|child| framePar.remove(child)}

        #Changement du nom
        builder.get_object("label_nomPark1").text="\#Unknown\#"

    end

    def cb_charged
        if combo_main.active==0 then
            cb_newPark
        else
            #Vidage des frames
            framePan.each{|child| framePan.remove(child)}
            framePar.each{|child| framePar.remove(child)}

            #Recuperation des vues panneau et parking utile
            nomPark =self.combo_main.active_text
            builder.get_object("label_nomPark1").text=nomPark
            vues=self.ctrl.get_park_views nomPark #Recup des 

            #Ajout des vues
            framePar.add_child(builder,vues[0],nil)
            framePan.add_child(builder,vues[1],nil)

            #Mise a jour des info du parking affichés
            _change_park_property(self.ctrl.get_park_info nomPark)
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
            builder.get_object("label_nomPark1").text = nomPark
            vues=self.ctrl.get_park_views nomPark

            #Ajout des vues
            framePar.add_child(builder,vues[0],nil)
            framePan.add_child(builder,vues[1],nil)

            #Mise a jour des info du parking affichés
            _change_park_property(self.ctrl.get_park_info nomPark)

            #Lien avec la combo du main
            combo_main.active=combo_load.active
        end
        windowWelcom.hide
        window.show_all
    end

    def _change_park_property tab
        builder.get_object("label_nomPark1").text = tab[0].to_s
        builder.get_object("entry_niv").text = tab[1].to_s
        builder.get_object("entry_place").text = tab[2].to_s
        builder.get_object("entry_haut").text = tab[3].to_s
        builder.get_object("entry_long").text = tab[4].to_s
    end

    def _get_park_property
        return [builder.get_object("label_nomPark1").text,builder.get_object("entry_niv").text.to_i,builder.get_object("entry_place").text.to_i,builder.get_object("entry_haut").text.to_i,builder.get_object("entry_long").text.to_i]
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

        #Mise en place des combo
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

    ##Preparation de la toolbar et menubar##
        #Creation du group d'action et des entrées
            #A faire
        voirStatCommercial=Proc.new{puts "OK"}
        voirStatAdmin=Proc.new{puts "OK"}
        quitterSauvegarder=Proc.new{puts "OK"}
        quitterSansSauvegarder=Proc.new{puts "OK"}
        aPropos=Proc.new{puts "OK"}
        nouveau=Proc.new{puts "OK"}
        supprimer=Proc.new{puts "OK"}
        carRandom=Proc.new{puts "OK"}
        carAcces1=Proc.new{puts "OK"}
        caracces2=Proc.new{puts "OK"}
        toutReprendre=Proc.new{puts "OK"}

        entrees = [
        ["Statistiques",nil,"_Statistiques",nil,nil],
        ["VoirStatCommercial", nil,"_VoirStatCommercial",nil,"Affiche les statistiques concernant le commercial",voirStatCommercial ],
        ["VoirStatAdmin", nil, "_VoirStatAdmin", nil, "Affiche les statistiques concernant l'administrateur", voirStatAdmin],
        ["Quitter",nil,"_Quitter",nil,nil],
        ["QuitterSauvegarder", Gtk::Stock::SAVE, "_QuitterSauvegarder", nil, "Quitter en sauvegardant l'etat", quitterSauvegarder],
        ["QuitterSansSauvegarder", Gtk::Stock::QUIT, "_Quitter", nil, "Quitte le programme sans sauvegarder", quitterSansSauvegarder],
        ["Aide",nil,"_Aide",nil,nil],
        ["APropos", Gtk::Stock::ABOUT, "A Propos", nil, "Plus d'information", aPropos],
        ["Nouveau", Gtk::Stock::NEW,"_Nouveau", nil, "Creer un nouveau parking", nouveau],
        ["Supprimer", Gtk::Stock::DELETE, "_Supprimer", nil, "Supprime le parking courant", supprimer],
        ["CarRandom", nil, "_CarRandom", nil, "Fais pop un vehicule a un acces aleatoire",  carRandom],
        ["CarAcces1", nil, "_CarAcces1",nil, "Fais pop un vehicule a l'acces 1", carAcces1],
        ["CarAcces2", nil, "_CarAcces2",nil, "Fais pop un vehicule a l'acces 2", carAcces2],
        ["ToutReprendre", nil, "_ToutReprendre", nil, "Reprend tous les vehicules d'un parking", toutReprendre]]
        
        # Crée un groupe d’action et lui ajoute toutes les actions.
        group = Gtk::ActionGroup.new("MainActionGroup")
        group.add_actions(entrees)

        #Creation de l'uimanager et des barres, ajout du groupe d'action
        uimanager = Gtk::UIManager.new
        uimanager.insert_action_group(group, 0)
        uimanager.add_ui("menu.ui")
        uimanager.add_ui("toolbar.ui")
        
        #recupération des barres et des accelerateurs
        menubar = uimanager.get_widget("/MenuBar")
        toolbar = uimanager.get_widget("/Toolbar")
        toolbar.toolbar_style = Gtk::Toolbar::Style::ICONS
        window.add_accel_group(uimanager.accel_group)

        #mise en place des barres
        vboxBar = builder.get_objetc("vbox_menu_main")
        vboxBar.pack_start_defaults(menubar)
        vboxBar.pack_start_defaults(toolbar)

        #Show all
        cb_welcom
        #@window.show_all

        #Build des signaux
        builder.connect_signals{ |handler| method(handler) }
    end
end
