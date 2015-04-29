# encoding: UTF-8

##
# Auteur Parmenon Damien 
#

# == Classe PartieDefiReussieBuilder :
#		- est un PartieReussieBuilder
class PartieDefiReussieBuilder < PartieReussieBuilder

	# Méthode d'instance

	# Méthode d'instance qui initialise le PartieDefiReussieBuilder
	def initialize()	# :nodoc:
        super()
		@nbEtoiles.file="Images/rien.png"
		@titre.label = "Défi réussi !"
	end
end