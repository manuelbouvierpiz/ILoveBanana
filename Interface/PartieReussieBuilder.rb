# encoding: UTF-8

##
# Auteur Parmenon Damien
#
require 'gtk2'

class PartieReussieBuilder < TakuzuBuilder

	def initialize
        super(__FILE__, "Partie Réussie")
       	score = Jeu.JEU.partie.calculerScore
      	@score.set_text("Score :" + score.to_s)
        @temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
        if(score > BaseDeDonnees.getGrilleEtoileTroisScore(Jeu.JEU.partie.grille.idGrille))
        	@nbEtoiles.file="Images/TroisEtoile.png"
        elsif(score > BaseDeDonnees.getGrilleEtoileDeuxScore(Jeu.JEU.partie.grille.idGrille))
        	@nbEtoiles.file="Images/DeuxEtoile.png"
        elsif(score > BaseDeDonnees.getGrilleEtoileUnScore(Jeu.JEU.partie.grille.idGrille))
        	@nbEtoiles.file="Images/UneEtoile.png"
        else
        	@nbEtoiles.file="Images/ZeroEtoile.png"
        end    
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
