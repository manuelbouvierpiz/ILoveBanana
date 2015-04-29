# encoding: UTF-8

##
# Auteur : Parmenon Damien
#
# == Classe PartieDefiBuilder :
#	- est un PartieBuilder
class PartieDefiBuilder < PartieBuilder
	
	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super(unePartie)
		@isDefi = true
		@image1.set_file("Images/rien.png")
		@meilleurScore.set_text("Score à battre :\n#{Jeu.JEU.partie.unScore}")
	end
	
	# * Méthode d'instance qui permet de modifier l'état d'une *Case*
	# * === Attributs :
	#		- unX : un entier représentant l'abscisse d'une Case
	#		- unY : un entier représentant l'ordonnée d'une Case
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		super(unX, unY)
		if Jeu.JEU.partie.grille.estCorrecte?
			self['window1'].signal_handler_disconnect(@handlerArret)
			Jeu.JEU.partie.arretChronometre()
			if(Jeu.JEU.partie.calculerScore > Jeu.JEU.partie.unScore)
				Jeu.JEU.partie.setVainqueur(Compte.COMPTE.pseudo, Jeu.JEU.partie.calculerScore)
				ouvrirFenetre(PartieDefiReussiBuilder.new)
			else
				Jeu.JEU.partie.setVainqueur(Jeu.JEU.partie.unJoueur, Jeu.JEU.partie.unScore)
				ouvrirFenetre(PartieDefiEchecBuilder.new)
			end
		elsif !Jeu.JEU.partie.verifierNbClicsMax?
			self['window1'].signal_handler_disconnect(@handlerArret)
			Jeu.JEU.partie.arretChronometre()
			Jeu.JEU.partie.setVainqueur(Jeu.JEU.partie.unJoueur, Jeu.JEU.partie.unScore)
			ouvrirFenetre(PartieDefiEchecBuilder.new)
		end
	end

	# * Méthode d'instance qui vérifie le temps de la *PartieDefi*
	# * Retourne *true* si le temps n'a pas atteint le temps max, *false* sinon
	def verifierTemps?()
		if(super())
			return true
		end
		ouvrirFenetre(PartieDefiEchecBuilder.new)
		return false
	end
	
end
