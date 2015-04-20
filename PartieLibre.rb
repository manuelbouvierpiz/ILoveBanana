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
			initGrilleAlea(unArgument, uneDifficulte)
		end
	end

	def initGrilleAlea(uneTaille, uneDifficulte)
		@grille = Grille.creer(uneTaille, uneDifficulte)
	end

	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
end
