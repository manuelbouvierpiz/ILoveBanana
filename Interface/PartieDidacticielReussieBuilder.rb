# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#
require 'gtk2'

class PartieDidacticielReussieBuilder < PartieReussieBuilder

	def initialize()
        super()
		@nbEtoiles.file="Images/rien.png"
		@bouton1.hide
	end

end
