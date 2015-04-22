# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#
require 'gtk2'

class PartieDidacticielReussieBuilder < TakuzuBuilder

	def initialize()
        super("./Interface/PartieReussieBuilder.rb", "Partie Réussie")
       	score = Jeu.JEU.partie.calculerScore
       	@nbEtoiles.file="Images/rien.png"
      	@score.set_text("Score :" + score.to_s)
        @temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
		Jeu.JEU.partie = nil
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
