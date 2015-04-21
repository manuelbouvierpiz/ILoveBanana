# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

require 'gtk2'

# == Classe +PartieMondeBuilder+ :
#	- est un +PartieBuilder+
class PartieMondeBuilder < PartieBuilder

	# Méthode de classe

	# * Méthode de classe qui permet de créer une +PartieBuilder+
	# ===== Attributs :
	#	- unMonde : un +Monde+ dans lequel se trouve la +Partie+
	#	- unePartie : une +Partie+ à lancer 
	def PartieMondeBuilder.creer(unePartie, unMonde)
		new(unePartie, unMonde)
	end

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie, unMonde)			# :nodoc:
		super(unePartie)
		
		@image1.set_file(unMonde.image)
		unScore = Compte.COMPTE.scorePourLeNiveau(Jeu.JEU.partie)
		if unScore > -1
			@meilleurScore.set_text("Meilleur score :\n" + unScore.to_s)
		else
			@meilleurScore.set_text("Meilleur score :\nAucun")
		end
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
