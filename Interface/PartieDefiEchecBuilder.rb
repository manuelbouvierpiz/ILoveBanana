# encoding: UTF-8

##
# Damien Parmenon
#

# == Classe PartieDefiEchecBuilder
#		- est un PartieEchecBuilder
class PartieDefiEchecBuilder < PartieEchecBuilder

	# Méthode d'instance

	# Méthode qui initialise le PartieDefiEchecBuilder
	def initialize	# :nodoc:
        super()
        @labelEchec.text = "Vous avez perdu le défi."
    end
end
