

class ChoixMondeBuilder < TakuzuBuilder

	def initialize 
        super(__FILE__,"Choix du Monde")
	end

	def go2Prairie
		monde=Jeu.JEU.aventure.mondes[0]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Foret
		monde=Jeu.JEU.aventure.mondes[1]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Mer
		monde=Jeu.JEU.aventure.mondes[2]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Dessert
		monde=Jeu.JEU.aventure.mondes[3]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Grotte
		monde=Jeu.JEU.aventure.mondes[4]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Volcan
		monde=Jeu.JEU.aventure.mondes[5]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Espace
		monde=Jeu.JEU.aventure.mondes[6]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2ArcEnCiel
		monde=Jeu.JEU.aventure.mondes[7]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def on_buttonRetour_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end

end
