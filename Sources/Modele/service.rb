require 'Hash'

#Classe service permettant de garder une trace des services proposés.
class Service
	attr_reader :entretien,:maintenance
	attr_writer :entretien,:maintenance

	def initialize
		self.entretien= Hash.new
		self.maintenance= Hash.new
	end
	
	def save(nomPark)
		#$db.execute "INSERT INTO panneau(nom, placeUsed, placeTot, park) VALUES ('#{nom}', #{placeUsed}, #{placeTot}, '#{nomPark}')"
	end

end

