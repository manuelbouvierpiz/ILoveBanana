# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

class PartieReussieBuilder < TakuzuBuilder

	def initialize()
        super(__FILE__, "Partie Réussie")
       	score = Jeu.JEU.partie.calculerScore
      	@score.set_text("Score :" + score.to_s)
        @temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
	end

	def on_button1_clicked
		ouvrirFenetre(TailleDifficulteBuilder.new)
	end

	def on_button2_clicked
		ouvrirFenetre(DefiBuilder.new)
	end

	def on_button3_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
end
