# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

class PartieReussieBuilder < TakuzuBuilder

	@idGrille
	@leScore

	def initialize()
		super(__FILE__)
		@leScore = Jeu.JEU.partie.calculerScore
		@idGrille = Jeu.JEU.partie.grille.idGrille
		Jeu.JEU.partie.gagner
		@score.set_text("Score :" + @leScore.to_s)
		@temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
		Jeu.JEU.partie.remiseAZero
		@button4.hide
	end

	def on_button1_clicked
		ouvrirFenetre(TailleDifficulteBuilder.new)
		Jeu.JEU.partie = nil
	end

	def on_button2_clicked
		ouvrirFenetre(DefiBuilder.creer(@idGrille, @leScore))
		Jeu.JEU.partie = nil
	end

	def on_button3_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
		Jeu.JEU.partie = nil
	end
end
