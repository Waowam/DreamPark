=begin
05/12/12

Eglem - Pinto

ctrlBorne.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueBorne.rb"

class Ctrl_borne

	attr_reader :mdl_borne,:vue_borne

	def initialize(borne)
		@mdl_borne = borne
		@vue_borne = Vue_borne.new(@mdl_borne.nom)
		@vue_borne.show_all
	end

	#Méthode de demande d'abonnement
	#Retourne un objet Abonne construit avec les informations récupérées.
	def ask_abonnement(v)
		
	end
	
	#Méthode de demande d'upgrade
	#Demande la confirmation d'abonnement
	def ask_upgrade(c)
		
	end
	
	#Méthode de demande de services
	def ask_services
		
	end
	
	#Méthode de demande de ask_paiement
	def ask_paiement
		true
	end

end
