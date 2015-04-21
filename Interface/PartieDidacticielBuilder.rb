# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

require 'gtk2'

# == Classe +PartieDidacticielBuilder+ :
#	- est un +PartieBuilder+
class PartieDidacticielBuilder < PartieBuilder

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super()
		
		@image1.set_file("Images/rien.png")
		@meilleurScore.set_text("")
	end
	
	# * Méthode d'instance qui permet de modifier l'état d'une +Case+
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		super(unX, unY)
		if Jeu.JEU.partie.grille.estCorrecte?
			Jeu.JEU.partie.arretChronometre()
			ouvrirFenetre(PartieLibreReussieBuilder.new)
		end
		
		if !Jeu.JEU.partie.verifierNbClicsMax?
			Jeu.JEU.partie.arretChronometre()
			ouvrirFenetre(PartieEchecBuilder.new)
		end
	end
	
end