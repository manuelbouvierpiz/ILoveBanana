class Aventure
	@mondes


	def Aventure.creer()
		new()
	end

	def initialize()
		@mondes =[Monde.creer(Village),Monde.creer(Prairie),Monde.creer(Foret),Monde.creer(Mer),Monde.creer(Desert),Monde.creer(Grotte),Monde.creer(Volcan),Monde.creer(Espace),Monde.creer(Arc-en-Ciel)]
	end

end