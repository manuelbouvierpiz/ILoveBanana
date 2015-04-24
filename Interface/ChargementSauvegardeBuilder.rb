# encoding: UTF-8

##
# Auteur Damien Parmenon et Valentin CHAILLOU
# Version 0.1 : Date : Fri Apr 03 17:52:21 CEST 2015
#

# == Classe +ChargementSauvegardeBuilder+ :
#		- est un +TakuzuBuilder+
#		- affiche une fenêtre permettant au joueur de terminer sa partie
class ChargementSauvegardeBuilder < TakuzuBuilder

	# Méthodes d'instance

	# Méthode d'instance qui initialise la fenêtre
    def initialize	# :nodoc:
		super(__FILE__)
    end
	
	# * Méthode d'instance qui crée une fenêtre et charge la partie sauvegardée
	# * Est automatiquement appelée par Gtk
    def on_buttonOui_clicked
    	ouvrirFenetre(PartieSauvegardeBuilder.creer(PartieSauvegarde.charger))
    end

	# * Méthode d'instance qui supprime la sauvegarde et ouvre le menu principal
	# * Est automatiquement appelée par Gtk
    def on_buttonNon_clicked
		Compte.COMPTE.supprimeSauvegarde()
    	ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
