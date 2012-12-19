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
		quest <<-EOF
		Nous vous proposons notre abonnement
		Il vous permettra de beneficier des services suivant : maintenance, entretien, livraison
		Voulez vous vous abonner ? (y/n) 
EOF
		mdl_borne.insert Q
		mdl_borne.majIter
		until mdl_borne.answer=="-1"
		end
		case mdl_borne.answer
			when "y"|"Y"
				mdl_borne.insert (mdl_borne.answer=="y" ? "y\n" : "Y\n")
				mdl_borne.majIter
			when "n"|"N"
				mdl_borne.insert (mdl_borne.answer=="n" ? "n\n" : "N\n")
				mdl_borne.majIter
			else
				ask_abonnement
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
