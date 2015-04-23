# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

# == Classe +PartieSauvegardeReussieBuilder+ :
#		- est un +PartieReussieBuilder+
#		- affiche une fenêtre indiquant que la +PartieSauvegarde+ est réussie
class PartieSauvegardeReussieBuilder < PartieReussieBuilder

	# Méthode d'instance
	
	# * Méthode d'instance qui initialise la fenêtre
	def initialize()
        super()
		@nbEtoiles.file="Images/rien.png"
		@button2.hide
	end

end
