=begin
13/12/12

Eglem - Pinto

vueParking.rb
=end

require 'gtk2'

class Vue_parking < Gtk::VBox

	attr_reader :ctrl

	def initialize(ctrl)
		super
		@ctrl = ctrl

		vuePop = Gtk::VBox.new
		vuePopImma = Gtk::HBox.new
			lbl_imm = Gtk::Label.new("Immatriculation :")
			txt_imma = Gtk::Entry.new
		vuePopHautLong = Gtk::HBox.new
			lbl_H = Gtk::Label.new("Hauteur :")
			lbl_L = Gtk::Label.new("Longueur :")
			spin_H= Gtk::SpinButton.new(10,500,1)
			spin_L=Gtk::SpinButton.new(10,500,1)
		butt_pop = Gtk::Button.new("Popper vehicule")
		
		vueList = Gtk::HBox.new
		butt_rep = Gtk::Button.new("Reprendre")

		#Liste de vehicule
		model_L = Gtk::ListStore.new(String,Integer,Integer)
		vue_L = Gtk::TreeView.new(model_L)

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
		vehi.each do |imma,haut,long|
			iter=model_L.append
			iter[0],iter[1],iter[2] = imma,haut,long
		end

		butt_pop.signal_connect('clicked') do
			ctrl.append_vehicule([txt_imma.text,spin_H.value.to_s,spin_L.value.to_s])
		end

		butt_rep.signal_connect('clicked') do
			iter = vue_L.selection.selected
			ctrl.remove_vehicule(iter)
		end

		vuePopImma.add(lbl_imm).add(txt_imma)
		vuePopHautLong.add(lbl_H).add(spin_H).add(lbl_L).add(spin_L)
		vuePop.add(vuePopImma).add(vuePopHautLong).add(butt_pop)
		vueList.add(vue_L).add(butt_rep)
		self.add(vuePop).add(vueList)
	end
end