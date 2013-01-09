=begin
13/12/12

Eglem - Pinto

ctrlParking.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueParking.rb"
require "../../Sources/Vue/vuePanneau.rb"

#Controleur de parking
class Ctrl_parking

	attr_reader :mdl_par,:vue_par,:vue_pan

	#Constructeur
	def initialize(mdl)
		@mdl_par = mdl
		@vue_par = Vue_parking.new(self)
		@vue_pan = Vue_panneau.new(self)
	end

	#Retourne la valeur que doivent prendre les panneaux
	def get_txt_panneau
		return [mdl_par.panneaux[0].to_s,mdl_par.panneaux[1].to_s]
	end

	#Retourne la liste des véhicules actuellement garés
	def get_vehicule
		v = []
		plce = mdl_par.place
		plce.each do |p| 
			v<<p.vehicule if p.vehicule != nil
		end
		return v
	end

	#Déclenche la mise à jour de la liste de véhicule
	def show_vehicule
		vue_par.maj_modele_liste_vehicule
	end

	#Déclenche la mise à jour des panneaux
	def show_panneau
		vue_pan.maj_panneau
	end

	#Permet l'apparition d'un véhicule aleatoire ou non sur les différents accès possibles
	def append_vehicule acces,tabV=nil
		error=0
		if tabV then
			puts "#{tabV}"
			mdl_par.listClient.each { |client| error=1	if client.immatriculation == tabV[0] }
			mdl_par.listAbonnes.each { |abonne| error=1	if abonne.immatriculation == tabV[0] }
		end

		if error == 0 && (acces == 0 || tabV[0].match(/(^\d{4}$)/) ) then
			case acces
				when 0
					indexAcc= rand(0..1)
					mdl_par.acces[indexAcc].capture_vehicule
				when 1
					imma,h,l= *tabV
					mdl_par.acces[0].capture_vehicule_with_info(imma,h,l)
				when 2
					imma,h,l= *tabV
					mdl_par.acces[1].capture_vehicule_with_info(imma,h,l)
			end
		else
			error=2 if not tabV[0].match(/(^\d{4}$)/)
			case error
				when 1
					dialog = Gtk::MessageDialog.new(nil, 
		                        Gtk::Dialog::DESTROY_WITH_PARENT,
		                        Gtk::MessageDialog::QUESTION,
		                        Gtk::MessageDialog::BUTTONS_CLOSE,
		                        "Ce vehicule existe deja dans ce parking"%tabV[0])
					dialog.run
					dialog.destroy
				when 2
					dialog = Gtk::MessageDialog.new(nil, 
		                        Gtk::Dialog::DESTROY_WITH_PARENT,
		                        Gtk::MessageDialog::QUESTION,
		                        Gtk::MessageDialog::BUTTONS_CLOSE,
		                        "Une erreur est survenu, l'immatriculation '%s' est surement invalide"%tabV[0])
					dialog.run
					dialog.destroy
			end
		end
	end

	#Permet la suppression d'un véhicule
	def remove_vehicule (iter)
		indexAcc= rand(0..1)
		vehiculeTemp = mdl_par.get_vehicule_with_info(iter[0],iter[1],iter[2])
		mdl_par.acces[indexAcc].est_sorti(vehiculeTemp)
		show_vehicule
		show_panneau
	end

	#Retourne les informations du modèle de ce controleur
	def get_info
		return [mdl_par.nom,mdl_par.nbNiv,mdl_par.nbPlaceNiv,mdl_par.hauteurMax,mdl_par.longueurMax]
	end

	#Permet l'affichage d'une boite de dialogue d'alerte affichant le texte passé en paramètre
	def alert_error text
		dialog = Gtk::MessageDialog.new(nil, 
		                        Gtk::Dialog::DESTROY_WITH_PARENT,
		                        Gtk::MessageDialog::QUESTION,
		                        Gtk::MessageDialog::BUTTONS_CLOSE,
		                        text)
					dialog.run
					dialog.destroy
	end
end