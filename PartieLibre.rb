# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8


class PartieLibre < Partie

	def PartieLibre.creer(uneTaille, uneDifficulte)
		new(uneTaille, uneDifficulte)
	end
	
	def initialize(unArgument, uneDifficulte=nil)
		unIdGrille = -1
		if uneDifficulte == nil		# unArgument = unIdGrille
			unIdGrille = unArgument
		else						# unArgument = uneTaille
			unIdGrille = BaseDeDonnees.getGrilleIdAleatoire(unArgument, uneDifficulte)
		end
		super(unIdGrille)
	end

	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
end
