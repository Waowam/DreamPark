=begin
05/12/12

Eglem - Pinto

ticket.rb
=end

class Ticket

	def initialize(nomPark="DreamPark",place=00, vehicule=nil, abonnee=nil)
		@nom = nomPark
		@time = Time.now.to_s
		@place = place
		@vehicule = vehicule
		@client = abonnee
	end

	def print
		result = ""
		result+= "----------------------------------\n"
		result+= @nom.center(20,'-')
		result+= "----------------------------------\n"
		result+= @time.center(20,' ')
		result+="\nPlace : #{@place}\n"
		result+="Client : #{@client}" if @client !=nil
		result+="Vehicule : #{@vehicule}" if @vehicule !=nil
		return result
	end
end
		
		

