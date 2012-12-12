=begin
05/12/12

Eglem - Pinto

ticket.rb
=end

class Ticket

	attr_reader :nom, :time, :place, :vehicule, :abonne
	attr_writer :nom, :time, :place, :vehicule, :abonne

	def initialize(nom, place, vehicule, abonne=nil)
		self.nom = nom
		self.time = Time.now.to_s
		self.place = place
		self.vehicule = vehicule
		self.abonne = abonne
	end

	def to_s
		result = ""
		result+= "----------------------------------\n"
		result+= @nom.center(20,'-')
		result+= "----------------------------------\n"
		result+= @time.center(20,' ')
		result+="\nPlace : #{@place}\n"
		result+="Client : #{@abonne}" if @abonne !=nil
		result+="Vehicule : #{@vehicule}"
		return result
	end
end
		
		

