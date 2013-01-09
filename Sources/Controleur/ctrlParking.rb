=begin
13/12/12

Eglem - Pinto

ctrlParking.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueParking.rb"
require "../../Sources/Vue/vuePanneau.rb"

class Ctrl_parking

	attr_reader :mdl_par,:vue_par,:vue_pan

	def initialize(mdl)
		@mdl_par = mdl
		@vue_par = Vue_parking.new(self)
		@vue_pan = Vue_panneau.new(self)
	end

	def get_txt_panneau
		return [mdl_par.panneaux[0].to_s,mdl_par.panneaux[1].to_s]
	end

	def get_vehicule
		v = []
		plce = mdl_par.place
		plce.each do |p| 
			v<<p.vehicule if p.vehicule != nil
		end
		return v
	end

	def show_vehicule
		vue_par.maj_modele_liste_vehicule
	end

	def show_panneau
		vue_pan.maj_panneau
	end

	def append_vehicule acces,tabV
		if acces==0 || tabV[0].match(/(^\d{4}$)/) then
			case acces
				when 0
					indexAcc= rand(0..1)
					puts "Acces #{indexAcc} = #{tabV}"

					mdl_par.acces[indexAcc].capture_vehicule
				when 1
					imma,h,l= *tabV
					mdl_par.acces[0].capture_vehicule(imma,h,l)
				when 2
					imma,h,l= *tabV
					mdl_par.acces[1].capture_vehicule(imma,h,l)
			end
		else
			dialog = Gtk::MessageDialog.new(nil, 
                        Gtk::Dialog::DESTROY_WITH_PARENT,
                        Gtk::MessageDialog::QUESTION,
                        Gtk::MessageDialog::BUTTONS_CLOSE,
                        "Une erreur est survenu, l'immatriculation '%s' est surement invalide"%tabV[0])
			dialog.run
			dialog.destroy
		end
	end

	def remove_vehicule (iter)
		indexAcc= rand(0..1)
		vehiculeTemp = mdl_par.get_vehicule_with_info(iter[0],iter[1],iter[2])
		mdl_par.acces[indexAcc].est_sorti(vehiculeTemp)
		show_vehicule
		show_panneau
	end

	def get_info
		return [mdl_par.nom,mdl_par.nbNiv,mdl_par.nbPlaceNiv,mdl_par.hauteurMax,mdl_par.longueurMax]
	end
end