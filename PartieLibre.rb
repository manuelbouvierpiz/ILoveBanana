# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8


class PartieLibre < Partie

	def PartieLibre.creer(uneTaille, uneDifficulte)
		new(uneTaille, uneDifficulte)
	end
	
	def initialize(unArgument, uneDifficulte=nil)
		if uneDifficulte == nil		# unArgument = unIdGrille
			super(unArgument)
		else						# unArgument = uneTaille
			@grille = Grille.creer(BaseDeDonnees.getGrilleIdAleatoire(unArgument, uneDifficulte))
		end
	end

	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
end
