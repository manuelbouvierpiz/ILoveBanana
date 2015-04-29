# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

# == Classe PartieLibreReussieBuilder :
#		est un PartieReussieBuilder
class PartieLibreReussieBuilder < PartieReussieBuilder

	# Méthode d'instance

	# Méthode d'instance qui initialise le PartieReussieBuilder
	def initialize()	# :nodoc:
        super()
		@nbEtoiles.file="Images/rien.png"
	end

end
