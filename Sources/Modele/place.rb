=begin
05/12/12

Eglem - Pinto

place.rb
=end

require "./parking.rb"
require "./vehicule.rb"

#Classe Place
#
#Classe représentant une place dans le parking.
#Elle est caractérisée par son numero, son niveau
#sa hauteur, sa longueur et son vehicule.
class Place

	attr_reader :num,:niveau,:hauteur,:longueur,:vehicule
	attr_writer :vehicule

	def initialize(num,niveau,hauteur,longueur)
		self.num=num
		self.niveau=niveau
		self.hauteur=hauteur
		self.longueur=longueur
		self.vehicule=nil
	end
	
	def num=(n)
		raise ArgumentError.new("Error : num must be positive.") if n <= 0
		@num= n
	end
	
	def niveau=(niv)
		raise ArgumentError.new("Error : niveau must be positive.") if niv < 0
		@niveau= niv
	end
	
	def hauteur=(h)
		raise ArgumentError.new("Error : hauteur must be positive.") if h <= 0
		@hauteur= h
	end
	
	def longueur=(l)
		raise ArgumentError.new("Error : longueur must be positive.") if l <= 0
		@longueur= l
	end
	
	def libre?
		vehicule.nil?
	end

	def to_s
		s ="Place n #{num}, niveau : #{niveau}, h : #{hauteur}, l : #{longueur} "
		s += vehicule.to_s if not libre?
		s += "LIBRE" if libre?
		return s
	end
	
	def save(nomPark)
		$db.execute "INSERT INTO place(num, niveau, hauteur, longueur, park) VALUES (#{num}, #{niveau}, #{hauteur}, #{longueur}, '#{nomPark}')"
		if not libre? then
			$db.execute "UPDATE place SET vehicule='#{vehicule.immatriculation}' WHERE num=#{num} AND park='#{nomPark}'"
		end	
	end
end
