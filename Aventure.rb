# Wilfried JOUSSE
# Modifications apportées par Valentin CHAILLOU

class Aventure

	attr_reader :mondes

	def Aventure.creer()
		new()
	end

	def initialize()
		@mondes =[Monde.creer(1),Monde.creer(2),Monde.creer(3),Monde.creer(4),Monde.creer(5),Monde.creer(6),Monde.creer(7),Monde.creer(8)]
	end

end
