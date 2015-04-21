# encoding: UTF-8

# Valentin CHAILLOU

# == Classe +ReglesBuilder+ :
#	- sait afficher les règles
class ReglesBuilder < TakuzuBuilder

    def initialize	# :nodoc:
		super(__FILE__, "Connexion")
    end

	# Méthode d'instance

	# * Méthode d'instance qui effectue le traitement du bouton retour
	# * Est appelée automaiquement par Gtk
	def on_boutonRetour_clicked
		ouvrirFenetrePrecedente
    end
end