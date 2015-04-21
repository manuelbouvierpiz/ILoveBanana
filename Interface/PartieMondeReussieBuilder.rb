# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#
require 'gtk2'

class PartieMondeReussieBuilder < PartieReussieBuilder

	def initialize()
        super()
		
		case Jeu.JEU.partie.nbEtoile
			when 0
				@nbEtoiles.file="Images/ZeroEtoile.png"
			when 1
				@nbEtoiles.file="Images/UneEtoile.png"
			when 2
				@nbEtoiles.file="Images/DeuxEtoile.png"
			when 3
				@nbEtoiles.file="Images/TroisEtoile.png"
		end
	end
end
