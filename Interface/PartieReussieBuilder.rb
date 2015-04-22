# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

class PartieReussieBuilder < TakuzuBuilder

	def initialize()
        super(__FILE__, "Partie Réussie")
       	score = Jeu.JEU.partie.calculerScore
		Jeu.JEU.partie.gagner
      	@score.set_text("Score :" + score.to_s)
        @temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
		Jeu.JEU.partie.remiseAZero
	end

	def on_button1_clicked
		ouvrirFenetre(TailleDifficulteBuilder.new)
		Jeu.JEU.partie = nil
	end

	def on_button2_clicked
		ouvrirFenetre(DefiBuilder.new(Jeu.JEU.partie.calculerScore, Jeu.JEU.partie.calculerScore))
		Jeu.JEU.partie = nil
	end

	def on_button3_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
		Jeu.JEU.partie = nil
	end
end
