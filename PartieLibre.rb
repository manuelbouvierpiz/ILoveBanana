# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8

load 'Partie.rb'

class PartieLibre < Partie

	def PartieLibre.creer(unCompte, uneTaille, uneDifficulte)
		new(unCompte, uneTaille, uneDifficulte)
	end

	def PartieLibre.creer(unCompte, unIdGrille)
		new(unCompte, unIdGrille)
	end

	def initialize(unCompte, uneTaille, uneDifficulte)
		@compte = unCompte
		initGrilleAlea(uneTaille, uneDifficulte)
	end

	def initialize(unCompte, unIdGrille)
		@compte = unCompte
		initGrille(unIdGrille)
	end

	def initGrilleAlea(uneTaille, uneDifficulte)
		@grille = Grille.new(uneTaille, uneDifficulte)
	end

	def listeDefis
		return BaseDeDonnees.getDefis(@compte)
	end
end