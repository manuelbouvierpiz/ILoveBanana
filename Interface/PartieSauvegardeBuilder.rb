# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe +PartieSauvegardeBuilder+ :
#	- est un +PartieBuilder+
class PartieSauvegardeBuilder < PartieBuilder

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super(unePartie)
		
		@image1.set_file("Images/rien.png")
		@meilleurScore.set_text("")
		
	end
	
	# * Méthode d'instance qui permet de modifier l'état d'une +Case+
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		super(unX, unY)
		if Jeu.JEU.partie.grille.estCorrecte?
			Jeu.JEU.partie.arretChronometre()
			ouvrirFenetre(PartieSauvegardeReussieBuilder.new)
		elsif !Jeu.JEU.partie.verifierNbClicsMax?
			Jeu.JEU.partie.arretChronometre()
			ouvrirFenetre(PartieEchecBuilder.new)
		end
	end
	
end
