=begin
11/12/12

Eglem - Pinto

ctrlGeneral.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueGeneral.rb"

class Ctrl_gen

	attr_reader :mdl_gen,:vue_gen

	#Constructeur
	def initialize(mdl)
		@mdl_gen = mdl
		@vue_gen = VueGeneral.new(self)
	end

	#Renvois les noms afin de mettre à jour la combobox des choix
	def maj_combo
		names=["Nouveau"]
		mdl_gen.parks.each do |p| 
			names<<p.nom
		end
		return names
	end

	#Permet la création d'un nouveau parking d'après les informations
	#fournis par la vue
	def post_park_info(park)
		mdl_gen.creerPark(park[0],park[1],park[2],park[3],park[4])
	end

	#Récupère les vues générés par le parking tel que
	#les vues des panneaux et la vue du parking
	def get_park_views(nom)
		ctrlP = mdl_gen.get_ctrl_park(nom)
		return [ctrlP.vue_par,ctrlP.vue_pan]
	end

	#Récupère les infos du parking courant
	def get_park_info(nom)
		return mdl_gen.get_ctrl_park(nom).get_info
	end

	#Retourne le nombre de parking actuel
	def nb_park
		return mdl_gen.parks.length
	end

	#Retourne l'index du parking actuel
	def getPos(nomP)
		mdl_gen.parks.each_with_index{|e,i| return i if e.nom==nomP}
	end

	#Permet la suppression du parking dans la base de donnée et le modèle
	#après la capture d'un évènement graphique
	def del_park nomP
		begin
			#Ouverture de la base de donnée
			$db = SQLite3::Database.open "dreampark.db"
			
			Database.save(nomP)
			
			rescue SQLite3::Exception => e 
			print "Exception occured in save (database.rb) : "
			puts e.message
		ensure
			$db.close if $db
		end
		index = mdl_gen.delete_park nomP
		return index
	end

	#Déclenche la sauvegarde de chacun des parkings
	def save_all_da_park
		@mdl_gen.parks.each { |p| p.save}
	end

	#Retourne les statistiques concernant les administrateurs sous forme de String
	def get_admin_stats(nomPark)
		parkTemp=nil
		mdl_gen.parks.each {|p| parkTemp=p if p.nom==nomPark}
		if parkTemp then
			stats = parkTemp.stats_admin
			stats_text="Parking : #{nomPark} \n"
			stats_text=stats_text+"Nombre de passage par l'acces Nord : #{stats["acces1"]}\n"
			stats_text=stats_text+"Nombre de passage par l'acces Sud : #{stats["acces2"]}\n"
			stats_text=stats_text+"Place la plus utilise : #{stats["place"]==0? "Aucune" : stats["place"]}\n"
		else
			stats_text="Aucune statistique disponible"
		end
		return stats_text
	end

	#Retourne les statistiques concernant les commerciaux sous forme de String
	def get_com_stats(nomPark)
		parkTemp=nil
		mdl_gen.parks.each {|p| parkTemp=p if p.nom==nomPark}
		if parkTemp then
			stats = parkTemp.stats_commercial
			stats_text="Parking : #{nomPark} \n"
			stats_text=stats_text+"Nombre de clients simples : #{stats["client"]}\n"
			stats_text=stats_text+"Nombre de clients abonnes : #{stats["abonne"]}\n"
			stats_text=stats_text+"Nombre d'entretiens totales : #{stats["entretien"]}\n"
			stats_text=stats_text+"Nombre de maintenances totales : #{stats["maintenance"]}\n"
			stats_text=stats_text+"Nombre des livraisons totales : #{stats["livraison"]}\n"
			stats_text=stats_text+"Nombre nombre de visites totales : #{stats["visites"]}\n"
			stats_text=stats_text+"Nombre nombre de packs totaux : #{stats["pack"]}\n"
		else
			stats_text="Aucune statistique disponible"
		end
		return stats_text
	end
end
