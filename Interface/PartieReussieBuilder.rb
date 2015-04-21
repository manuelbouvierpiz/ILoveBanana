# encoding: UTF-8

##
# Auteur Parmenon Damien
#
require 'gtk2'

class PartieReussieBuilder < TakuzuBuilder

	def initialize()
        super(__FILE__, "Partie Réussie")
       	score = Jeu.JEU.partie.calculerScore
      	@score.set_text("Score :" + score.to_s)
        @temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
		
		case Jeu.JEU.partie.nbEtoile
			when -1		# Non concerné
				@nbEtoiles.file="Images/rien.png"
			when 0
				@nbEtoiles.file="Images/ZeroEtoile.png"
			when 1
				@nbEtoiles.file="Images/UneEtoile.png"
			when 2
				@nbEtoiles.file="Images/DeuxEtoile.png"
			when 3
				@nbEtoiles.file="Images/TroisEtoile.png"
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
