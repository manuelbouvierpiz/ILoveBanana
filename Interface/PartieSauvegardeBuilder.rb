# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe PartieSauvegardeBuilder :
#	- est un PartieBuilder
class PartieSauvegardeBuilder < PartieBuilder

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super(unePartie)
		
		@image1.set_file("Images/rien.png")
		@meilleurScore.set_text("")

		# Mise à jour du temps toutes les secondes
		GLib::Timeout.add(1000) do
			begin
				@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
				if !Jeu.JEU.partie.verifierTempsMax?
					self['window1'].signal_handler_disconnect(@handlerArret)
					Jeu.JEU.partie.arretChronometre
					ouvrirFenetre(PartieEchecBuilder.new)
				end
				true
			rescue
				false
			end
		end
		
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
			ouvrirFenetre(PartieSauvegardeReussieBuilder.new)
		elsif !Jeu.JEU.partie.verifierNbClicsMax?
			self['window1'].signal_handler_disconnect(@handlerArret)
			Jeu.JEU.partie.arretChronometre()
			ouvrirFenetre(PartieEchecBuilder.new)
		end
	end

	# * Méthode d'instance qui vérifie le temps de la *PartieSauvegarde*
	# * Retourne *true* si le temps n'a pas atteint le temps max, *false* sinon
	def verifierTemps?()
		if(super())
			return true
		end
		ouvrirFenetre(PartieEchecBuilder.new)
		return false
	end
	
end
