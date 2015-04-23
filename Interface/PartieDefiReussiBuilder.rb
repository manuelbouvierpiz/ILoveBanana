# encoding: UTF-8

##
# Auteur Parmenon Damien 
#

class PartieDefiReussiBuilder < PartieReussieBuilder

	def initialize()
        super()
		@nbEtoiles.file="Images/rien.png"
		@titre.label = "Défi réussi !"
	end
end