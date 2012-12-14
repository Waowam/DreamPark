=begin
05/12/12

Eglem - Pinto

ticket.rb
=end

class Ticket

	attr_reader :nom, :time, :place, :vehicule
	attr_writer :nom, :time, :place, :vehicule

	def initialize(numPlace, vehicule)
		self.time = Time.now.to_s
		self.place = numPlace
		self.vehicule = vehicule
		self.nom = "Ticket P#{self.place}V#{self.vehicule.immatriculation} - #{self.time}"
	end

	def to_s
		result = "----------------------------------\n"
		result+= @nom.center(20,'-')
		result+= "----------------------------------\n"
		result+= @time.center(20,' ')
		result+="\nPlace : #{@place}\n"
		result+="Client : #{@vehicule.abonne}" if @vehicule.abonne !=nil
		result+="Vehicule : #{@vehicule}"
		return result
	end
	
	def save(nomPark, nomBorne)
		$db.execute "INSERT INTO ticket(nom, time, place, vehicule, park, borne) VALUES 
					('#{nom}', '#{time}', #{place}, '#{vehicule.immatriculation}', '#{nomPark}', '#{nomBorne}')"
	end
end
		
		

