# Wilfried JOUSSE
# Modifications apportées par Valentin CHAILLOU


class Aventure

	attr_reader :mondes

	def Aventure.creer()
		new()
	end

	def initialize()
		@mondes =[Monde.creer(1, "Images/prairie.png"),Monde.creer(2, "Images/foret.png"),Monde.creer(3, "Images/mer.png"),Monde.creer(4, "Images/desert.png"),Monde.creer(5, "Images/grotte.png"),Monde.creer(6, "Images/volcan.png"),Monde.creer(7, "Images/espace.png"),Monde.creer(8, "Images/arc-en-ciel.png")]
	end

end
