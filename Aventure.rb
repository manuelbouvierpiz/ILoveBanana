class Aventure

	attr_reader :mondes

	def Aventure.creer()
		new()
	end

	def initialize()
		@mondes =[Monde.creer(1, "Village"),Monde.creer(2, "Prairie"),Monde.creer(3, "Foret"),Monde.creer(4, "Mer"),Monde.creer(5, "Desert"),Monde.creer(6, "Grotte"),Monde.creer(7, "Volcan"),Monde.creer(8, "Espace"),Monde.creer(9, "Arc-en-Ciel")]
	end

end
