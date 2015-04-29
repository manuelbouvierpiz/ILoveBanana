# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

# == Classe PartieDidacticielReussieBuilder :
#		est un PartieReussieBuilder
class PartieDidacticielReussieBuilder < PartieReussieBuilder

	# Méthode d'instance

	# Méthode d'instance qui initialise le PartieReussieBuilder
	def initialize()	# :nodoc:
        super()
		@nbEtoiles.file="Images/rien.png"
		@button2.hide
	end
	
end
