=begin
11/12/12

Eglem - Pinto

ctrlGeneral.rb
=end

require 'gtk2'
require "../../Sources/Vue/vueGeneral.rb"

class Ctrl_gen

	attr_reader :mdl_gen,:vue_gen

	def initialize(mdl)
		@mdl_gen = mdl
		@vue_gen = VueGeneral.new(self)
	end

	def maj_combo
		names=["Nouveau"]
		mdl_gen.parks.each do |p| 
			names<<p.nom
		end
		return names
	end

	def post_park_info(park)
		mdl_gen.creerPark(park[0],park[1],park[2],park[3],park[4])
	end

	def get_park_views(nom)
		ctrlP = mdl_gen.get_ctrl_park(nom)
		return [ctrlP.vue_par,ctrlP.vue_pan]
	end

	def get_park_info(nom)
		return mdl_gen.get_ctrl_park(nom).get_info
	end

	def nb_park
		return mdl_gen.parks.length
	end

	def getPos(nomP)
		mdl_gen.parks.each_with_index{|e,i| return i if e.nom==nomP}
	end

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

	def save_all_da_park
		@mdl_gen.parks.each { |p| p.save}
	end
end
