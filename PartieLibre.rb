# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8

load 'Partie.rb'

class PartieLibre < Partie

	def PartieLibre.creer(uneTaille, uneDifficulte)
		new(uneTaille, uneDifficulte)
	end

	def PartieLibre.creer(unIdGrille)
		new(unIdGrille)
	end

	def initialize(uneTaille, uneDifficulte)
		initGrilleAlea(uneTaille, uneDifficulte)
	end

	def initialize(unIdGrille)
		initGrille(unIdGrille)
	end

	def initGrilleAlea(uneTaille, uneDifficulte)
		@grille = Grille.creer(uneTaille, uneDifficulte)
	end

	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
end
