=begin
05/12/12

Eglem - Pinto

vueBorne.rb
=end

require 'gtk2'

#Classe de vue de la borne permettant l'intéraction partielle entre
#les clients et la borne du parking afin d'effectuer les choix et le paiement.
class Vue_borne

        attr_reader :builder,:window,:entree,:console,:buffer,:endIter,:answer, :num_scenario,:ctrl
        attr_writer :num_scenario

        #Fonction d'insertion du texte passé en paramètre
        def insert text
        	buffer.insert(endIter,text)
          endIter=buffer.end_iter
        end

        #Action du bouton valider, il réagis selon la tournure du scénario pris par 
        #le client.
        def clkd_valider
          puts "Method : clkd_valider, num_scenario : #{num_scenario}"
         case num_scenario
                when 1
                    puts "Scenario de l'abonnement : "
        	        answer=entree.text
        	        puts "ANSWER = #{answer}"
                    if answer.match(/[yY]/) then
                      #si oui, on l'envoi au scenar d'adhesion.
                        @num_scenario=5
                    elsif answer.match(/[nN]/) then
                      #si non, paiement direct
                        @num_scenario=4
                    end
                    #sinon on change rien, ça relancera ask_abonnement
                    puts "nouveau num_scenario : #{num_scenario}"
                when 2
                       puts "Scenario des services : "
                       answer=entree.text
                       puts "ANSWER = #{answer}"
                       @num_scenario=3
                when 3
                       puts "Scenario de l'upgrade : "
                       answer=entree.text
                       puts "ANSWER = #{answer}"
                       @num_scenario=4
                when 4
                       puts "Scenario de paiement : "
                       answer=entree.text
                       puts "ANSWER = #{answer}"
                       @num_scenario=(-1)
                when 5
                      puts "Scenario de l'adhesion :"
                      answer=entree.text
                      puts "ANSWER = #{answer}"
                      @num_scenario=2
         end
         insert (answer+"\n")
         entree.text=""
         ctrl.replay_scenarios
        end

        #Constructeur
        def initialize ctrl
        	 #Builder de la fenetre
          @builder = Gtk::Builder.new
          @builder.add_from_file( "../Vue/borne.glade" )

          #Attribut d'état de la vue 1 = ask_abonnement, 2 = ask_service, 3 = ask_upgrade, 4 = ask_paiement,5 = ask_adhesion
          @num_scenario = (-1)

          #Controleur borne
          @ctrl 	= ctrl

          #Elements principaux
          @window       = builder.get_object( "vue_borne" ) #Fenetre entière
          @entree 	  = builder.get_object( "entry" ) #Entree texte
          @console 	  = builder.get_object( "text_console" ) #Console
          @buffer 	  = builder.get_object( "textbuffer1" )	#BUFFFFEEERR
          @endIter 	  = buffer.end_iter
          @answer		  = "-1"

          #Init les buffers
          buffer.insert(endIter,"Bienvenu !\n")
          endIter = buffer.end_iter

          #window.show_all

          #Build des signaux
          builder.connect_signals{ |handler| method(handler) }
        end
end

