=begin
05/12/12

Eglem - Pinto

ctrlBorne.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueBorne.rb"

class Ctrl_borne

	def initialize(borne)
		@mdl_borne = borne
		@vue_borne = Vue_borne.new(@mdl_borne.nom)
		@vue_borne.show_all
	end

	def ask_abonnement
		#Méthode de demande d'ask_abonnement
	end

	def ask_paiement
		#Méthode de demande de ask_paiement
	end

end