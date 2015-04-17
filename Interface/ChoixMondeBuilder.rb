##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class ChoixMondeBuilder < TakuzuBuilder

	def initialize 
        super(__FILE__,"Choix du Monde")
	end

	def go2Village
		monde=Jeu.JEU.Aventure.mondes[1]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Prairie
		monde=Jeu.JEU.Aventure.mondes[2]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Foret
		monde=Jeu.JEU.Aventure.mondes[3]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Mer
		monde=Jeu.JEU.Aventure.mondes[4]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Dessert
		monde=Jeu.JEU.Aventure.mondes[5]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Grotte
		monde=Jeu.JEU.Aventure.mondes[6]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Volcan
		monde=Jeu.JEU.Aventure.mondes[7]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2Espace
		monde=Jeu.JEU.Aventure.mondes[8]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

	def go2ArcEnCiel
		monde=Jeu.JEU.Aventure.mondes[8]
		ouvrirFenetre(ChoixGrilleBuilder.new(monde))
	end

end
