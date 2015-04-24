# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe +PartieMondeBuilder+ :
#	- est un +PartieBuilder+
class PartieMondeBuilder < PartieBuilder

	# Variable d'instance
	
	# * Variable d'instance qui représente le +Monde+ la +PartieMonde+
	@monde

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
		
		@monde = unMonde
		
		@image1.set_file(unMonde.image)
		unScore = Compte.COMPTE.scorePourLaGrille(Jeu.JEU.partie.grille)
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
			self['window1'].signal_handler_disconnect(@handlerArret)
			ouvrirFenetre(PartieLibreReussieBuilder.creer(@monde))
		end
		
		if !Jeu.JEU.partie.verifierNbClicsMax?
			self['window1'].signal_handler_disconnect(@handlerArret)
			Jeu.JEU.partie.arretChronometre()
			ouvrirFenetre(PartieEchecBuilder.new)
		end
	end

end
