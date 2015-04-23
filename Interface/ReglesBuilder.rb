# encoding: UTF-8

# Valentin CHAILLOU

# == Classe +ReglesBuilder+ :
#	- sait afficher les règles
class ReglesBuilder < TakuzuBuilder

	# Méthodes d'instance

    def initialize	# :nodoc:
		super(__FILE__, "Règles")
    end

	# * Méthode d'instance qui effectue le traitement du bouton retour
	# * Est appelée automaiquement par Gtk
	def on_boutonRetour_clicked
		ouvrirFenetrePrecedente
		Jeu.JEU.partie.repriseChronometre
    end
end