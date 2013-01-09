=begin
13/12/12

Eglem - Pinto

vueParking.rb
=end

require 'gtk2'

#Classe de la vue d'une parking relatant les histoires de tous ses petits vehicules.
class Vue_parking < Gtk::VBox

	attr_reader :ctrl,:model_L
	attr_writer :model_L

	#Constructeur
	def initialize(ctrl)
		super
		@ctrl = ctrl
		vueTot = Gtk::VBox.new
		vuePop = Gtk::VBox.new
		vuePopImma = Gtk::HBox.new
			lbl_imm = Gtk::Label.new("Immatriculation :")
			txt_imma = Gtk::Entry.new
		vuePopHautLong = Gtk::HBox.new
			lbl_H = Gtk::Label.new("Hauteur :")
			lbl_L = Gtk::Label.new("Longueur :")
			spin_H= Gtk::SpinButton.new(100,500,1)
			spin_L=Gtk::SpinButton.new(100,500,1)
		vueButPop = Gtk::HBox.new
			butt_pop = Gtk::Button.new("Detection acces 1")
			butt_pop2 = Gtk::Button.new("Detection acces 2")
			butt_popAlea = Gtk::Button.new("Detection aleatoire")
		
		butt_rep = Gtk::Button.new("Reprendre")

		#Liste de vehicule
		@model_L = Gtk::ListStore.new(String,Integer,Integer)
		vue_L = Gtk::TreeView.new(model_L)
		scrollWindow = Gtk::ScrolledWindow.new
		scrollWindow.set_policy(Gtk::POLICY_NEVER,Gtk::POLICY_ALWAYS)

		colonne_I = Gtk::TreeViewColumn.new("Immatriculation",
											Gtk::CellRendererText.new, :text => 0 )
		vue_L.append_column(colonne_I)
		colonne_H = Gtk::TreeViewColumn.new("Hauteur",
											Gtk::CellRendererText.new, :text => 1 )
		vue_L.append_column(colonne_H)
		colonne_L = Gtk::TreeViewColumn.new("Longueur",
											Gtk::CellRendererText.new,:text => 2 )
		vue_L.append_column(colonne_L)

		vue_L.selection.set_mode(Gtk::SELECTION_SINGLE)

		vehi = ctrl.get_vehicule
		vehi.each do |v|
			iter = @model_L.append
			iter[0],iter[1],iter[2] = v.immatriculation,v.hauteur,v.longueur
		end

		butt_pop.signal_connect('clicked') do
			ctrl.append_vehicule(1,[txt_imma.text,spin_H.value.to_s.to_i,spin_L.value.to_s.to_i])
		end

		butt_pop2.signal_connect('clicked') {ctrl.append_vehicule(2,[txt_imma.text,spin_H.value.to_s.to_i,spin_L.value.to_s.to_i])}

		butt_popAlea.signal_connect('clicked') do
			ctrl.append_vehicule(0)
		end
		butt_rep.signal_connect('clicked') do
			iter = vue_L.selection.selected
			ctrl.remove_vehicule(iter) if iter != nil
		end

		vuePopImma.add(lbl_imm).add(txt_imma)
		vuePopHautLong.add(lbl_H).add(spin_H).add(lbl_L).add(spin_L)
		vueButPop.add(butt_pop).add(butt_pop2).add(butt_popAlea)
		vuePop.pack_start(vuePopImma,false,false,0).pack_start(vuePopHautLong,false,false,0).pack_start(vueButPop,false,true,0).pack_start(butt_rep,false,true,0)
		scrollWindow.add(vue_L)
		vueTot.pack_start(vuePop,false,false,0).pack_start(scrollWindow,true,true,0)
		self.add(vueTot)
	end

	#Fonction de mise à jour de la liste des véhicules garés
	def maj_modele_liste_vehicule
		vehi = ctrl.get_vehicule
		@model_L.clear
		vehi.each do |v|
			iter = @model_L.append
			iter[0],iter[1],iter[2] = v.immatriculation,v.hauteur,v.longueur
		end
	end
end
