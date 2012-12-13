=begin
05/12/12

Eglem - Pinto

ticket.rb
=end

class Ticket

	attr_reader :nom, :time, :place, :vehicule
	attr_writer :nom, :time, :place, :vehicule

	def initialize(place, vehicule)
		self.time = Time.now.to_s
		self.place = place
		self.vehicule = vehicule
		self.nom = "Ticket P#{place.num}V#{vehicule.immatriculation} - #{self.time}"
	end

	def to_s
		result = ""
		result+= "----------------------------------\n"
		result+= @nom.center(20,'-')
		result+= "----------------------------------\n"
		result+= @time.center(20,' ')
		result+="\nPlace : #{@place}\n"
		result+="Client : #{@vehicule.abonne}" if @vehicule.abonne !=nil
		result+="Vehicule : #{@vehicule}"
		return result
	end
end
		
		

