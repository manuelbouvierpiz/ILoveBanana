# encoding: UTF-8

##
# Auteur : Parmenon Damien
#
# == Classe +PartieDefiBuilder+ :
#	- est un +PartieBuilder+
class PartieDefiBuilder < PartieBuilder

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
			if(Jeu.JEU.partie.calculerScore > Jeu.JEU.partie.unScore)
				Jeu.Jeu.partie.setVainqueur(Compte.COMPTE.pseudo, Jeu.JEU.partie.calculerScore)
				ouvrirFenetre(PartieDefiReussieBuilder.new)
			else
				Jeu.Jeu.partie.setVainqueur(Jeu.JEU.partie.unJoueur, Jeu.JEU.partie.unScore)
				ouvrirFenetre(PartieEchecBuilder.new)
			end
		elsif !Jeu.JEU.partie.verifierNbClicsMax?
			Jeu.JEU.partie.arretChronometre()
			Jeu.Jeu.partie.setVainqueur(Jeu.JEU.partie.unJoueur, Jeu.JEU.partie.unScore)
			ouvrirFenetre(PartieEchecBuilder.new)
		end
	end
	
end