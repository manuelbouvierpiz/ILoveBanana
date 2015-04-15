# encoding: UTF-8

##
# Auteur Parmenon Damien
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'

class PartieReussieBuilder < TakuzuBuilder

	def initialize
        super(__FILE__, "Partie Réussie")
       	score = 102#jeu.JEU.partie.calculerScore
      	@score.set_text("Score :" + score.to_s)
        @temps.set_text("Temps :" + 20.to_s)#Jeu.JEU.partie.getTemps())
        if(score > 100)#BaseDeDonnees.getGrilleEtoileTroisScore(jeu.JEU.partie.grille.idGrille))
        	@nbEtoiles = Gtk::Image.new("Images/TroisEtoile.png")
        elsif(score > BaseDeDonnees.getGrilleEtoileDeuxScore(jeu.JEU.partie.grille.idGrille))
        	@nbEtoiles = Gtk::Image.new("Images/DeuxEtoile.png")
        elsif(score > BaseDeDonnees.getGrilleEtoileUnScore(jeu.JEU.partie.grille.idGrille))
        	@nbEtoiles = Gtk::Image.new("Images/UneEtoile.png")
        else
        	@nbEtoiles = Gtk::Image.new("Images/ZeroEtoile.png")
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

    Gtk.init
    PartieReussieBuilder.new
    Gtk.main
end
