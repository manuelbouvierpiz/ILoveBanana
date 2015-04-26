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
		super(unIdGrille, uneDifficulte >= 8)
	end

	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
	
	# * Méthode d'instance qui arrête la *PartieLibre*
	def arreteToi
		super()
		arretChronometre()
	end
	
	# * Méthode d'instance qui "termine" la *PartieLibre*
	# * Retourne *self*
	def gagner
		# On ne met à jour la BDD que si le score est meilleur
		unScore = calculerScore()
		if unScore > Compte.COMPTE.scorePourLaGrille(@grille)
			BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, 0, @nbHypotheses, @nbAides, unScore)
		end
		return super()
	end
	
end
