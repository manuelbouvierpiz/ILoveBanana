# encoding: UTF-8

##
# Auteur Parmenon Damien 
#

class PartieDefiReussieBuilder < PartieReussieBuilder

	def initialize()
        super()
		@nbEtoiles.file="Images/rien.png"
		@titre.label = "Défi réussi !"
	end
end