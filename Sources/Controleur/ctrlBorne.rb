=begin
05/12/12

Eglem - Pinto

ctrlBorne.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueBorne.rb"

class Ctrl_borne

	attr_accessor :mdl_borne,:vue_borne

	#Constructeur
	def initialize(borne)
		@mdl_borne = borne
		@vue_borne = Vue_borne.new(self)
	end

	#Affiche la vue de la borne
	def show_view
		vue_borne.window.show_all
	end

	#Permet l'enchainement des scenarios
	def replay_scenarios
		mdl_borne.apply_scenarios
	end

	#Méthode de demande d'abonnement
	#Retourne un objet Abonne construit avec les informations récupérées.
	def ask_abonnement
		quest=
		"Nous vous proposons notre abonnement\nIl vous permettra de beneficier des services suivant : maintenance, entretien, livraison\nVoulez vous vous abonner ? (y/n)\n"
		vue_borne.insert quest
		#La réponse est géré par la méthode de gestion de click du boutton valider
	end
	
	#Méthode de demande d'upgrade
	#Demande la confirmation d'abonnement
	def ask_upgrade
		quest=
		"Nous vous proposons de devenir membre prenium !\nAinsi vous profiterez d'une place assuree dans nos parkings.\nVoulez vous le devenir ? (y/n) \n"
		vue_borne.insert quest
	end
	
	#Méthode de demande de services
	def ask_services
		quest=
		"En tant qu'abonne, vous avez le droit aux services que nous proposons :\n\t1 - Maintenance\n\t2 - Entretien\n\t3 - Livraison\n\t0 - Rien\n"
		vue_borne.insert quest
	end
	
	#Méthode de demande de ask_paiement
	def ask_paiement
		quest=
		"Veuillez effectue le paiement, au choix :\n\t1 - Carte Bleue\n\t2 - Especes\n"
		vue_borne.insert quest
	end

	#Méthode de demande d'adhésion, n correspondant a l'étape
	def ask_adhesion n
		case n
			when 1
				quest=
				"Par la suite nous allons receuillir vos informations d'abonne.\nVeuillez specifier votre nom : "
				vue_borne.insert quest
			when 2
				quest=
				"Veuillez specifier votre prenom : "
				vue_borne.insert quest
			when 3
				quest=
				"Veuillez specifier votre adresse : "
				vue_borne.insert quest
			when 4
		end
	end

	#Dit aurevoir !
	def say_bybye
		quest=
		"Merci et aurevoir"
		vue_borne.insert quest
	end

	#Remet à zéro la vue
	def reset_view
		@vue_borne.window.hide
		@vue_borne=Vue_borne.new(self)
	end
end
