# encoding: UTF-8

##
# Damien Parmenon
#

# == Classe PartieEchecBuilder :
#		- est un TakuzuBuilder
class PartieEchecBuilder < TakuzuBuilder

	# Méthodes d'instance

	# Méthode d'instance qui initialise le PartieEchecBuilder
	def initialize		# :nodoc:
        super(__FILE__)
		Jeu.JEU.partie.remiseAZero
		Jeu.JEU.partie = nil
    end

	# * Méthode d'instance qui ouvre la fenêtre du menu principal
	# * est automatiquement appelée par Gtk
    def on_buttonRetour_clicked
    	ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
