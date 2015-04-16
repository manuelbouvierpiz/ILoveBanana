# encoding: UTF-8

##
# Auteur : Group 1
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

load 'Interface/TakuzuBuilder.rb'
load 'Interface/TailleDifficulteBuilder.rb'
load 'Defi.rb'
load 'Compte.rb'

class DefiBuilder < TakuzuBuilder
	
	attr :grille , false
	
	attr :score , false
	
    def initialize
        super(__FILE__, "Defi")
    end
    
    	def on_validerButton_clicked
		Defi.creer(Compte.COMPTE.pseudo,labelPseudo,@grille,@score)
		case @grille.taille
			when 6
				ouvrirFenetre(Partie6Builder.creer(PartieLibre.creer(6,@grille.difficulte)))
			when 8
				ouvrirFenetre(Partie8Builder.creer(PartieLibre.creer(8,@grille.difficulte)))
			when 10
				ouvrirFenetre(Partie10Builder.creer(PartieLibre.creer(10,@grille.difficulte)))
			when 12
				ouvrirFenetre(Partie12Builder.creer(PartieLibre.creer(12,@grille.difficulte)))
		end
	end
	
	#Methode de classe qui fermer le defi
	def on_annulerButton_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new())
	end
	
	
	#Méthode de classse
	# * Méthode de classe qui lance l'interface graphique
	def DefiBuilder.lancer
		Gtk.init
		DefiBuilder.new()
		Gtk.main
    	end
    	
    	def DefiBuilder.creer(uneGrille,unScore)
    		@grille = uneGrille
    		@score = unSocre
    	end
end
