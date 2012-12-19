=begin
05/12/12

Eglem - Pinto

ctrlBorne.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueBorne.rb"

class Ctrl_borne

	attr_accessor :mdl_borne,:vue_borne

	def initialize(borne)
		@mdl_borne = borne
		@vue_borne = Vue_borne.new(@mdl_borne.nom)
	end

	def show_view
		vue_borne.window.show_all
	end

	#Méthode de demande d'abonnement
	#Retourne un objet Abonne construit avec les informations récupérées.
	def ask_abonnement v
		quest=
		"Nous vous proposons notre abonnement\nIl vous permettra de beneficier des services suivant : maintenance, entretien, livraison\nVoulez vous vous abonner ? (y/n)"
		vue_borne.insert quest
		vue_borne.maj_iter
		until vue_borne.answer=="-1"
		end
		case vue_borne.answer
			when "y"
				vue_borne.insert (vue_borne.answer=="y" ? "y\n" : "Y\n")
				vue_borne.maj_iter
			when "n"
				vue_borne.insert (vue_borne.answer=="n" ? "n\n" : "N\n")
				vue_borne.maj_iter
			else
				#ask_abonnement v
		end
	end
	
	#Méthode de demande d'upgrade
	#Demande la confirmation d'abonnement
	def ask_upgrade c
		
	end
	
	#Méthode de demande de services
	def ask_services
		
	end
	
	#Méthode de demande de ask_paiement
	def ask_paiement
		true
	end

end
