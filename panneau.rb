=begin
04/12/12

Eglem - Pinto

panneau.rb
=end

class Panneau
	attr_reader :txt
	attr_writer :txt

	def initialize(txt="0")
		@text=txt
	end

	def changer_text(txt)
		@text = txt
	end
end