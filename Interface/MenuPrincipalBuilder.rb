# encoding: UTF-8

##
# Auteur Alexandre Moutel (glade), Parmenon Damien (code ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe MenuPrincipalBuilder : 
#   - Permet à l'utilisateur de pouvoir naviguer dans l'application en permettant l'accés aux différentes fonctionnalités de celle-ci
class MenuPrincipalBuilder < TakuzuBuilder

	# Méthodes

	# * Méthode d'instance qui initialise la fenêtre correspondante au +MenuPrincipalBuilder+
	def initialize 
        super(__FILE__, "Menu Principal")
	end

	# * Méthode d'instance qui ouvre la fenêtre TailleDifficulte si l'utilisateur clique sur le bouton correspondant afin de lancer une partie rapide
	def on_partieRapideButton_clicked
		ouvrirFenetre(TailleDifficulteBuilder.new)
	end

	# * Méthode d'instance qui ouvre la fenêtre Aventure si l'utilisateur clique sur le bouton correspondant
	def on_aventureButton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre correspondant à une partie permettant d'apprendre à jouer
	def on_didacticielButton_clicked
		ouvrirFenetre(PartieBuilder.new())
	end
	
	# * Méthode d'instance qui ouvre la fenêtre Options si l'utilisateur clique sur le bouton correspondant
	def on_optionButton_clicked
		ouvrirFenetre(OptionsBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre Statistiques si l'utilisateur clique sur le bouton correspondant
	def on_statistiquesButton_clicked
		Compte.COMPTE.succes.verifierTousLesSucces()
		ouvrirFenetre(StatistiquesBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre d'à propos si l'utilisateur clique sur le bouton correspondant
	def on_aProposButton_clicked
		ouvrirFenetre(AProposBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre de Connexion si l'utilisateur clique sur le bouton correspondant
	def on_retourButton_clicked
		ouvrirFenetre(ConnexionBuilder.new)
	end
	
	# * Méthode d'instance qui permet de fermer intégralement l'application
	def on_quitterButton_clicked
		Gtk.main_quit
	end
end
