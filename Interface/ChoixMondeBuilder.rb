require 'gtk2'

#changer le path unshift pour chercher dans le répertoire père 
$LOAD_PATH.unshift File.expand_path("../../Interface", __FILE__)
load 'TakuzuBuilder.rb'

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
