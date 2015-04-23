# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

class PartieDidacticielReussieBuilder < PartieReussieBuilder

	def initialize()
        super()
		@nbEtoiles.file="Images/rien.png"
		@button2.hide
	end
	
end
